resource "helm_release" "astronomer" {
  name             = "astronomer"
  repository       = "https://helm.astronomer.io"
  chart            = "astronomer"
  version          = var.astronomer_version
  namespace        = kubernetes_namespace.astronomer.metadata[0].name
  cleanup_on_fail  = true
  atomic           = true
  timeout          = 900

  values = [
    yamlencode({
      global = {
        # Base domain for all Astronomer ingress routes
        baseDomain = var.base_domain

        # Use externally-managed TLS secret (cert-manager or pre-existing)
        tlsSecret = "astronomer-tls"

        # Disable built-in PostgreSQL - we use external RDS
        postgresqlEnabled = false

        # Airflow image tag
        airflowVersion = "2.9.1"
      }

      astronomer = {
        houston = {
          serviceAccount = {
            annotations = {
              "eks.amazonaws.com/role-arn" = aws_iam_role.houston.arn
            }
          }

          config = {
            email = {
              enabled  = var.smtp_enabled
              smtpUrl  = var.smtp_enabled ? "smtps://${var.smtp_username}:${var.smtp_password}@${var.smtp_host}:${var.smtp_port}" : ""
              reply    = "noreply@${var.base_domain}"
              from     = "noreply@${var.base_domain}"
              fromName = "Astronomer"
            }

            auth = {
              local = {
                enabled = true
              }
            }
          }

          db = {
            connectionStringSecretName = kubernetes_secret.astronomer_db.metadata[0].name
            connectionStringSecretKey  = "connection"
          }
        }

        airflow = {
          serviceAccount = {
            annotations = {
              "eks.amazonaws.com/role-arn" = aws_iam_role.airflow_scheduler.arn
            }
          }
        }
      }

      # Nginx ingress controller
      nginx = {
        enabled = true
        loadBalancerIP = ""
        serviceType = "LoadBalancer"
        privateLoadBalancer = true
        annotations = {
          "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
          "service.beta.kubernetes.io/aws-load-balancer-type"     = "nlb"
        }
      }

      # cert-manager for TLS
      certManager = {
        enabled = true
      }

      # Prometheus + Grafana stack
      prometheus = {
        enabled = true
      }

      grafana = {
        enabled = true
      }

      # Elasticsearch for Airflow task logs
      elasticsearch = {
        enabled = true
        data = {
          replicas = 3
          resources = {
            requests = {
              cpu    = "500m"
              memory = "2Gi"
            }
            limits = {
              memory = "4Gi"
            }
          }
          persistence = {
            enabled      = true
            storageClass = "gp2"
            size         = "100Gi"
          }
        }
      }

      # Kibana for log visualization
      kibana = {
        enabled = true
      }

      # Fluentd log shipper
      fluentd = {
        enabled = true
      }

      # S3 remote log configuration for Airflow
      airflow = {
        airflow = {
          config = {
            AIRFLOW__LOGGING__REMOTE_LOGGING        = "True"
            AIRFLOW__LOGGING__REMOTE_BASE_LOG_FOLDER = "s3://${aws_s3_bucket.astronomer_logs.bucket}/logs"
            AIRFLOW__LOGGING__REMOTE_LOG_CONN_ID    = "aws_default"
            AIRFLOW__LOGGING__ENCRYPT_S3_LOGS       = "False"
          }
        }

        workers = {
          serviceAccount = {
            annotations = {
              "eks.amazonaws.com/role-arn" = aws_iam_role.airflow_worker.arn
            }
          }
        }
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.astronomer,
    kubernetes_secret.astronomer_db,
    kubernetes_secret.astronomer_platform,
    aws_db_instance.astronomer,
  ]
}
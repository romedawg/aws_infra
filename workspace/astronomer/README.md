# Astronomer on EKS — Terraform Deployment

This workspace deploys the [Astronomer Software](https://www.astronomer.io/docs/software/overview) platform onto an existing EKS cluster using the official Astronomer Helm chart. Astronomer wraps Apache Airflow with a multi-deployment control plane (Houston API), a web UI (Orbit), observability stack, and a managed ingress layer.

---

## What Was Created

### Module: `modules/infrastructure/astronomer/`

A reusable Terraform module that provisions everything Astronomer needs to run on EKS. Files and their purpose:

| File | What it does |
|---|---|
| `main.tf` | Declares required provider versions |
| `variables.tf` | All input variables with descriptions and defaults |
| `locals.tf` | Derived name prefix, common tags, OIDC URL normalization |
| `security_groups.tf` | RDS security group allowing PostgreSQL ingress from EKS worker nodes |
| `rds.tf` | Multi-AZ PostgreSQL 15 RDS instance with Enhanced Monitoring, automated backups, and credentials stored in Secrets Manager |
| `s3.tf` | Two encrypted S3 buckets — one for Airflow task logs, one for DAGs — with versioning, SSE-KMS, and public access blocked |
| `iam.tf` | Three IRSA roles: `airflow-scheduler` (S3 + Secrets Manager), `airflow-worker` (S3), `houston` (Secrets Manager) |
| `k8s.tf` | Kubernetes namespace, and Kubernetes secrets wiring DB credentials and platform secrets into the cluster |
| `helm.tf` | `helm_release` deploying the Astronomer chart with all component values |
| `outputs.tf` | Exposes RDS endpoint, S3 bucket names, IRSA role ARNs, Helm status |

### Workspace: `workspace/astronomer/`

The environment-specific deployment that calls the module.

| File | What it does |
|---|---|
| `backend.tf` | S3 remote state in `terraform-romedawg` bucket |
| `provider.tf` | AWS, Kubernetes, and Helm providers; Kubernetes/Helm auth via EKS cluster token |
| `locals.tf` | All environment values — account ID, VPC, subnets, SG, OIDC, domain, admin email |
| `main.tf` | Module call wiring locals into the module |
| `outputs.tf` | Surfaces URLs, bucket names, RDS endpoint, secret ARN, Helm status |

---

## Architecture

```
EKS Cluster (existing)
└── astronomer namespace
    ├── Houston API          — Astronomer control plane (IRSA → Secrets Manager)
    ├── Orbit UI             — Web dashboard
    ├── NATS                 — Message bus
    ├── nginx ingress        — NLB (internal) → *.astronomer.dev.internal.gohealth.net
    ├── cert-manager         — TLS certificate provisioning
    ├── Prometheus + Grafana — Metrics
    ├── Elasticsearch        — Airflow task log storage (3-replica)
    ├── Kibana               — Log visualization
    └── Fluentd              — Log shipping

AWS Resources
├── RDS PostgreSQL 15 (Multi-AZ, db.t3.medium)   — Astronomer metadata DB
├── S3: astronomer-dev-airflow-logs-{account}     — Task logs (90-day expiry)
├── S3: astronomer-dev-airflow-dags-{account}     — DAG storage
├── Secrets Manager: astronomer-dev/db-credentials
├── Secrets Manager: astronomer-dev/platform-credentials
└── IAM IRSA roles (3): scheduler, worker, houston
```

---

## Prerequisites

Before running `terraform apply`, ensure the following are true:

### 1. EKS Cluster is Running
The cluster must exist and be reachable. The Kubernetes and Helm providers authenticate using `aws_eks_cluster_auth`, which requires your local AWS credentials to have `eks:DescribeCluster` and `eks:ListClusters` permissions.

### 2. Fill in OIDC Values in `locals.tf`
The OIDC provider ID (the hex string at the end of the OIDC URL) must match your actual cluster. Get it by running:
```bash
aws eks describe-cluster \
  --name dev \
  --region us-east-2 \
  --query "cluster.identity.oidc.issuer" \
  --output text
```
Then replace the `XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX` placeholder in `locals.tf` with the ID portion of that URL.

### 3. DNS for the Base Domain
Astronomer needs DNS records pointing `*.astronomer.dev.internal.gohealth.net` to the NLB that nginx creates. After the first `terraform apply`, get the NLB hostname:
```bash
kubectl get svc -n astronomer astronomer-nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
```
Create a wildcard CNAME in Route 53 (or your DNS provider):
```
*.astronomer.dev.internal.gohealth.net → <nlb-hostname>
```

### 4. TLS Certificate
Astronomer expects a Kubernetes secret named `astronomer-tls` in the `astronomer` namespace containing a valid TLS cert for `*.astronomer.dev.internal.gohealth.net`. Either:

- **cert-manager (recommended):** The chart deploys cert-manager automatically. Create an `Issuer` or `ClusterIssuer` and a `Certificate` resource targeting that domain. If using ACM Private CA or Let's Encrypt via DNS-01, configure the issuer after the first apply.

- **Pre-existing cert:** Create the secret manually before applying:
  ```bash
  kubectl create secret tls astronomer-tls \
    --cert=tls.crt \
    --key=tls.key \
    -n astronomer
  ```

### 5. Sufficient Node Capacity
The full Astronomer stack (control plane + Elasticsearch + monitoring) needs at least **3 nodes of `m5.xlarge`** or equivalent (16 vCPU / 48 GB total recommended). The existing node group uses `m5.xlarge` — ensure the desired count is ≥ 3.

### 6. Helm and kubectl Installed Locally
```bash
helm version   # >= 3.10
kubectl version --client
```

---

## Deployment Steps

```bash
cd workspace/astronomer

# Initialize providers and backend
terraform init

# Review what will be created (~25 resources)
terraform plan

# Deploy (RDS creation takes ~10 min; Helm release ~15 min)
terraform apply
```

After apply completes:
1. Check the Helm release status: `terraform output helm_release_status`
2. Verify pods are running: `kubectl get pods -n astronomer`
3. Retrieve the NLB hostname and update DNS (see Prerequisites §3)
4. Access the platform at `https://app.astronomer.dev.internal.gohealth.net`

---

## Module Inputs Reference

| Variable | Required | Default | Description |
|---|---|---|---|
| `environment` | yes | — | Environment name (`dev`, `staging`, `prod`) |
| `aws_region` | yes | — | AWS region |
| `aws_account_id` | yes | — | AWS account ID |
| `vpc_id` | yes | — | VPC where RDS is placed |
| `private_subnet_ids` | yes | — | Private subnets for RDS subnet group |
| `eks_cluster_name` | yes | — | Name of existing EKS cluster |
| `eks_node_security_group_id` | yes | — | SG on EKS workers (RDS ingress) |
| `oidc_provider_arn` | yes | — | EKS OIDC provider ARN for IRSA |
| `oidc_provider_url` | yes | — | EKS OIDC provider URL (no `https://`) |
| `base_domain` | yes | — | Base domain for Astronomer ingress |
| `admin_email` | yes | — | Platform admin email |
| `astronomer_version` | no | `0.34.0` | Astronomer Helm chart version |
| `db_instance_class` | no | `db.t3.medium` | RDS instance type |
| `db_allocated_storage` | no | `50` | RDS initial storage (GB) |
| `db_max_allocated_storage` | no | `200` | RDS max autoscale storage (GB) |
| `db_deletion_protection` | no | `true` | RDS deletion protection |
| `db_backup_retention_days` | no | `7` | RDS backup window (days) |
| `astronomer_namespace` | no | `astronomer` | Kubernetes namespace |
| `smtp_enabled` | no | `false` | Enable email notifications |
| `smtp_host` | no | `""` | SMTP host |
| `smtp_port` | no | `587` | SMTP port |
| `smtp_username` | no | `""` | SMTP username (sensitive) |
| `smtp_password` | no | `""` | SMTP password (sensitive) |
| `tags` | no | `{}` | Extra AWS resource tags |

---

## Secrets

All sensitive values are generated by Terraform (`random_password`) and stored in AWS Secrets Manager. They are never stored in state as plaintext beyond what Terraform normally tracks.

| Secret | Path in Secrets Manager | Contents |
|---|---|---|
| DB credentials | `astronomer-dev/db-credentials` | username, password, host, port, dbname |
| Platform secrets | `astronomer-dev/platform-credentials` | secret_key, jwt_secret, admin_email |

The DB password is also projected into a Kubernetes secret (`astronomer-db-credentials`) so the Helm chart can reference it without needing AWS credentials at runtime.

---

## Upgrading Astronomer

To upgrade the chart version, update `astronomer_version` in `workspace/astronomer/main.tf` and run `terraform apply`. The `helm_release` resource will perform a `helm upgrade` in-place. Check the [Astronomer Software release notes](https://www.astronomer.io/docs/software/release-notes) before upgrading — some versions require DB migrations.

---

## Teardown

```bash
# Disable deletion protection first (if enabled for prod)
# Then:
terraform destroy
```

Note: the S3 buckets have `force_destroy = false`. You must manually empty them before `terraform destroy` will succeed.

// manual steps
chose domain 
kubectl create namespace astronomer

# domains
// BASEDOMAIN=astronomer.dev.internal.gohealth.net
app.dev.internal.gohealth.net
deployments.dev.internal.gohealth.net
registry.dev.internal.gohealth.net
houston.dev.internal.gohealth.net
grafana.dev.internal.gohealth.net
kibana.dev.internal.gohealth.net
install.dev.internal.gohealth.net
alertmanager.dev.internal.gohealth.net
prometheus.dev.internal.gohealth.net
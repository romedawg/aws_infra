resource "kubernetes_namespace" "astronomer" {
  metadata {
    name = var.astronomer_namespace

    labels = {
      name        = var.astronomer_namespace
      environment = var.environment
    }
  }
}

# Astronomer platform-level credentials (bootstrap secret for Houston)
resource "random_password" "astronomer_secret_key" {
  length  = 64
  special = false
}

resource "random_password" "astronomer_houston_jwt_secret" {
  length  = 64
  special = false
}

resource "aws_secretsmanager_secret" "astronomer_platform" {
  name                    = "${local.name_prefix}/platform-credentials"
  description             = "Astronomer platform secret key and JWT secret"
  recovery_window_in_days = 7
  tags                    = local.common_tags
}

resource "aws_secretsmanager_secret_version" "astronomer_platform" {
  secret_id = aws_secretsmanager_secret.astronomer_platform.id
  secret_string = jsonencode({
    secret_key  = random_password.astronomer_secret_key.result
    jwt_secret  = random_password.astronomer_houston_jwt_secret.result
    admin_email = var.admin_email
  })
}

# Kubernetes secret: Astronomer database connection
resource "kubernetes_secret" "astronomer_db" {
  metadata {
    name      = "astronomer-db-credentials"
    namespace = kubernetes_namespace.astronomer.metadata[0].name
  }

  data = {
    connection = "postgresql://${var.db_username}:${random_password.db_password.result}@${aws_db_instance.astronomer.endpoint}/${var.db_name}"
    username   = var.db_username
    password   = random_password.db_password.result
    host       = aws_db_instance.astronomer.address
    port       = tostring(aws_db_instance.astronomer.port)
    dbname     = var.db_name
  }

  type = "Opaque"
}

# Kubernetes secret: Astronomer platform secrets
resource "kubernetes_secret" "astronomer_platform" {
  metadata {
    name      = "astronomer-platform"
    namespace = kubernetes_namespace.astronomer.metadata[0].name
  }

  data = {
    "secret-key"  = random_password.astronomer_secret_key.result
    "jwt-secret"  = random_password.astronomer_houston_jwt_secret.result
    "admin-email" = var.admin_email
  }

  type = "Opaque"
}

# Kubernetes secret: SMTP credentials (only if SMTP enabled)
resource "kubernetes_secret" "astronomer_smtp" {
  count = var.smtp_enabled ? 1 : 0

  metadata {
    name      = "astronomer-smtp"
    namespace = kubernetes_namespace.astronomer.metadata[0].name
  }

  data = {
    "smtp-uri" = "smtps://${var.smtp_username}:${var.smtp_password}@${var.smtp_host}:${var.smtp_port}"
  }

  type = "Opaque"
}
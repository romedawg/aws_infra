resource "aws_secretsmanager_secret" "newrelic_license_key" {
  count = var.store_nr_license_key_to_secret_manager ? 1 : 0

  name = "newrelic-license-key"
}

locals {
  newrelic_license_key = {
    LicenseKey = var.newrelic_license_key
  }
}

resource "aws_secretsmanager_secret_version" "instance" {
  count = var.store_nr_license_key_to_secret_manager ? 1 : 0

  secret_id     = aws_secretsmanager_secret.newrelic_license_key[0].id
  secret_string = jsonencode(local.newrelic_license_key)
}

resource "aws_ssm_parameter" "ssm_license_key" {
  count = var.store_nr_license_key_to_ssm ? 1 : 0

  name  = "/all/new_relic/license_key"
  value = var.newrelic_license_key
  type  = "SecureString"
}


resource "aws_ssm_parameter" "ssm_license_key_data" {
  count = var.store_nr_license_key_to_ssm ? 1 : 0

  name  = "/all/new_relic/license_key_data"
  value = var.newrelic_license_key
  type  = "SecureString"
}

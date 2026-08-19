module "newrelic_basic" {
  source = "./newrelic_provided_code/newrelic-config"

  name = var.account_name

  newrelic_account_id = var.newrelic_external_id
  nr_admin_key        = var.newrelic_admin_key

  role_name_override = var.role_name_override

  newrelic_metric_stream_namespaces = var.newrelic_metric_stream_namespaces
}

module "newrelic_log_ingestion" {
  source = "./newrelic_provided_code/aws-log-ingestion"

  count = var.newrelic_log_ingestion_enable ? 1 : 0

  nr_logging_enabled = true
  nr_infra_logging   = false
  nr_license_key     = var.newrelic_license_key
  nr_tags            = "env:${var.environment}"
}

module "newrelic_license_key_storage" {
  count = 1

  source = "./newrelic_license_key_storage"

  newrelic_license_key = var.newrelic_license_key

  store_nr_license_key_to_ssm            = var.store_nr_license_key_to_ssm
  store_nr_license_key_to_secret_manager = var.store_nr_license_key_to_secret_manager
}

resource "aws_iam_role_policy_attachment" "attach_all" {
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = var.role_name_override == "" ? "NewRelicInfrastructure-Integrations-${var.account_name}" : var.role_name_override
}

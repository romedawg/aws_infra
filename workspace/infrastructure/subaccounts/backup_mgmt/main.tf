module "iam_policies" {
  source = "../../../../modules/infrastructure/iam"
}

module "qa_kms_vault_key" {
  source                = "../../../../modules/infrastructure/kms/create_key"
  key_name              = "qa-vault"
  service_name          = "qa vault"
  deletion_windows_days = 7
}

module "qa-vault" {
  source             = "../../../../modules/infrastructure/aws_backup_vault"
  environment        = "qa"
  service            = "non-prod"
  kms_key_arn        = module.qa_kms_vault_key.kms_key_arn
  organization_id    = local.aws_orgization_id
  vault_name         = "qa-vault-air"
  create_vault_lock  = false
  max_retention_days = 30
  min_retention_days = 7
}



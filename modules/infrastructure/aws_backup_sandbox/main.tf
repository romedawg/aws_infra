module "rds_kms_key" {
  source            = "./kms"
  key_name          = "rds"
  source_account_id = ""
}

module "rds_vault" {
  source             = "./vault"
  kms_key_arn        = module.rds_kms_key.kms_arn
  vault_service_name = "rds"
  source_account_id  = "024441264067"
}

module "backup_plan" {
  source     = "./backup_plan"
  vault_name = module.rds_vault.vault_name
}
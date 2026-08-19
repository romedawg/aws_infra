module "assets_permissions" {
  source          = "../iam/assets"
  root_account_id = local.root_account_id
}

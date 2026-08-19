module "terraform_state_access" {
  source     = "./terraform_state_access"
  for_each   = toset(["base", "vendor"])
  type       = each.key
  account_id = var.account_id
}

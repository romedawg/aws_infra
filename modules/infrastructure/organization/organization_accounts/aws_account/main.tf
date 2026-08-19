resource "aws_organizations_account" "account" {
  email     = var.root_user_email
  name      = var.account_name
  parent_id = var.parent_id

  lifecycle {
    prevent_destroy = true
  }
}

module "terraform_state_access" {
  source     = "./terraform_state_access"
  for_each   = toset(["base", "vendor"])
  type       = each.key
  account_id = aws_organizations_account.account.id
}

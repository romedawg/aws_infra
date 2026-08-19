resource "aws_servicecatalog_provisioned_product" "account" {
  name = var.account_name

  # Acquired directly from console
  product_id = "prod-5p3skx5yyokue"

  # Based on aws servicecatalog list-provisioning-artifacts --product-id 'prod-5p3skx5yyokue'
  provisioning_artifact_id = "pa-v7i6uggugloy4"

  provisioning_parameters {
    key   = "AccountName"
    value = var.account_name
  }

  provisioning_parameters {
    key   = "AccountEmail"
    value = var.root_user_email
  }

  provisioning_parameters {
    key   = "ManagedOrganizationalUnit"
    value = var.parent_id
  }

  tags = {
    configuration_item = var.configuration_item
  }
  lifecycle {
    prevent_destroy = true
  }
}

module "terraform_state_access" {
  source     = "./terraform_state_access"
  for_each   = toset(["base", "vendor"])
  type       = each.key
  account_id = local.account_id
}

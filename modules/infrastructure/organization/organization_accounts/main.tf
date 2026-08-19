data "aws_organizations_organization" "organization" {}

resource "aws_organizations_organizational_unit" "network" {
  parent_id = data.aws_organizations_organization.organization.roots[0].id
  name      = "network"
}

# TODO try creating account this way
module "network" {
  source                 = "./aws_manually_created_account"
  account_name           = "network"
  administrator_ad_group = "Admin"
  share_resources        = true
  account_id             = "539839777600"
}

module "sandbox" {
  source                 = "./aws_manually_created_account"
  account_name           = "sandbox"
  administrator_ad_group = "Admin"
  share_resources        = true
  account_id             = "024441264067"
}

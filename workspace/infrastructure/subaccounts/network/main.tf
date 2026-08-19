module "iam" {
  source = "../../../../modules/infrastructure/subaccounts-infra/general_aws_account_iam"
}

// Base accounts for cicd pipelines
module "terraform_infra" {
  source = "../../../../modules/infrastructure/subaccounts-infra/terraform_infra"
}

module "network_env" {
  source = "../../../../modules/infrastructure/subaccounts-infra/networking"

  account_name = "${local.system}-${local.environment}"
  aws_region   = local.aws_region
  environment  = local.environment
  vpc_cidr     = local.vpc_cidr
  system       = local.system

  vpc_subnet_cidr_blocks = local.vpc_subnet_cidr_blocks

  resolver_rule_id = local.resolver_rule_id

  availability_zone = local.aws_region
}

// Share GH Network Egress TGW with sub-accounts
module "share_tgw_method_qa" {
  source          = "../../../../modules/infrastructure/subaccounts-infra/networking/ram-share"
  sub_account_ids = local.sub_account_ids
  egress_tgw_arn  = module.network_env.egress_tgw_arn
}

# module "waf" {
#   source = "../../../../modules/infrastructure/waf"
#
#   environment = "all"
#
#   accounts = [
#     // API Gateway QA
#     "",
#     // API Gateway UAT
#     "",
#     // API Gateway PROD
#     "",
#   ]
# }

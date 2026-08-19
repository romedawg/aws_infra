module "network" {
  source     = "./organisational_account"
  account_id = var.managed_organization_accounts["network"].account_id
  associated_resource_arns = {
    # prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
    prefix_corp_and_ops = "arn:aws:ec2:us-east-2:701164309191:prefix-list/pl-00b29bd1eeae9e00c"
    # prefix_env          = var.managed_prefix_arns["qa_environments"]
    # prefix_uat          = var.managed_prefix_arns["uat_environments"]
    transit_gateway = var.transit_gateway_arn
    dns_resolver    = data.aws_route53_resolver_rule.norvax_all.arn
  }
}

module "sandbox" {
  source     = "./organisational_account"
  account_id = var.managed_organization_accounts["sandbox"].account_id
  associated_resource_arns = {
    # prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
    prefix_corp_and_ops = "arn:aws:ec2:us-east-2:701164309191:prefix-list/pl-00b29bd1eeae9e00c"
    # prefix_env          = var.managed_prefix_arns["qa_environments"]
    # prefix_uat          = var.managed_prefix_arns["uat_environments"]
    transit_gateway = var.transit_gateway_arn
    dns_resolver    = data.aws_route53_resolver_rule.norvax_all.arn
  }
}

# module "gohealth_uat" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth UAT"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_env          = var.managed_prefix_arns["uat_environments"]
#     prefix_qa           = var.managed_prefix_arns["qa_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "gohealth_PROD" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth PROD"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_env          = var.managed_prefix_arns["prod_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "qa_mysql" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["MySQL QA"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_env          = var.managed_prefix_arns["qa_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "uat_mysql" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth MySQL UAT"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_env          = var.managed_prefix_arns["uat_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "prod_mysql" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth MySQL PROD"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_env          = var.managed_prefix_arns["prod_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "qa_mssql" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth MS SQL QA"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_env          = var.managed_prefix_arns["qa_environments"]
#     prefix_all_mysql    = var.managed_prefix_arns["all_mysql_cidrs"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "uat_mssql" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth MS SQL UAT"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_env          = var.managed_prefix_arns["uat_environments"]
#     prefix_all_mysql    = var.managed_prefix_arns["all_mysql_cidrs"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "prod_mssql" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth MS SQL PROD"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_env          = var.managed_prefix_arns["prod_environments"]
#     prefix_all_mysql    = var.managed_prefix_arns["all_mysql_cidrs"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# // Repurposed for Backup Management
# module "qa_astronomer" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth Backup Management"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_env          = var.managed_prefix_arns["qa_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "prod_astronomer" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth Astronomer PROD"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_env          = var.managed_prefix_arns["prod_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
#
#   is_external_account = true
# }
#
# module "databricks" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth Data Bricks"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["qa_environments"]
#     prefix_uat          = var.managed_prefix_arns["uat_environments"]
#     prefix_prod         = var.managed_prefix_arns["prod_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "it_infra" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["IT Infra"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["qa_environments"]
#     prefix_uat          = var.managed_prefix_arns["uat_environments"]
#     prefix_prod         = var.managed_prefix_arns["prod_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "callrecording_qa" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["Call Recording QA"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_prod         = var.managed_prefix_arns["qa_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "callrecording_uat" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["Call Recording UAT"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_prod         = var.managed_prefix_arns["uat_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "callrecording" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["Call Recording"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_prod         = var.managed_prefix_arns["prod_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "network_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["Network Account"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["qa_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "api_gateway_qa_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["API Gateway QA"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["qa_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "api_gateway_uat_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["API Gateway UAT"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["uat_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "api_gateway_prod_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["API Gateway PROD"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_prod         = var.managed_prefix_arns["prod_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "cicd_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth CICD"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "data_science" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["Data Science"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "cognito_qa_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth Cognito QA"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["qa_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "cognito_uat_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth Cognito UAT"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["uat_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "cognito_prod_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GoHealth Cognito PROD"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_prod         = var.managed_prefix_arns["prod_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "cognito_carrier_testing_consumer_qa_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["Cognito Carrier Testing Consumer QA"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["qa_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "cognito_carrier_testing_consumer_uat_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["Cognito Carrier Testing Consumer UAT"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["uat_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "gps_agents_cognito_qa_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GPS Agents GoHealth Cognito QA"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["qa_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "gps_agents_cognito_uat_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GPS Agents GoHealth Cognito UAT"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_uat          = var.managed_prefix_arns["uat_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "gps_agents_cognito_prod_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GPS Agents GoHealth Cognito PROD"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_prod         = var.managed_prefix_arns["prod_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "ai_tooling_qa_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["GH AWS AI Tooling"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     prefix_qa           = var.managed_prefix_arns["qa_environments"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }
#
# module "zscaler_account" {
#   source     = "./organisational_account"
#   account_id = var.managed_organization_accounts["ZScaler"].account_id
#   associated_resource_arns = {
#     prefix_corp_and_ops = var.managed_prefix_arns["corp_and_ops"]
#     transit_gateway     = var.transit_gateway_arn
#     dns_resolver        = data.aws_route53_resolver_rule.norvax_all.arn
#   }
# }

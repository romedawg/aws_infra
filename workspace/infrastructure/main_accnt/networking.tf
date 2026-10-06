

# Controll tower, dont really need that here
# module "global_resources" {
#   source = "../../../modules/infrastructure/subaccounts-infra/global_resources"
# }

module "env" {
  source = "../../../modules/infrastructure/subaccounts-infra/environment-with-common-network"

  account_name = "call-recording-qa"
  environment  = local.environment
  system = "main" // generic name to define the account
  aws_region   = local.aws_region

  access_from_internet      = true
  vpc_cidr                  = local.vpc_cidr
  vpc_subnets = local.vpc_subnets
  # additional_tgw_routes_prefixlist = [local.main_accnt_prefix_list_id]
  route_all_private_subnets = false
  egress_tgw_id = "tgw-05898830bb0231e59" // Network Egress transit_gateway_id
  internet_transit_gateway_id = "tgw-05898830bb0231e59" // Network Egress transit_gateway_id
  use_egress_tgw = false

  adawsread_dn       = "test"
  adawsread_password = "test"

  newrelic_external_id = "1234" // fix this
  newrelic_license_key = "1234"
  newrelic_admin_key   = "1234"

  store_nr_license_key_to_secret_manager = true
  store_nr_license_key_to_ssm            = true

  private_route_table_association = true // Use the private route table association for AD subnets

  associated_hosted_zone_ids = [
    # local.romedawg_hosted_zone,
  ]

  # newrelic_metric_stream_namespaces = ["AWS/SNS", "AWS/SQS", "AWS/AutoScaling"]
  newrelic_metric_stream_namespaces = []
  resolver_rule_id = ""
}
module "common_network" {
  source           = "../common-network"
  aws_region       = var.aws_region
  environment      = var.environment
  resolver_rule_id = var.resolver_rule_id

  rome_transit_gateway_id     = local.rome_transit_gateway_id
  internet_transit_gateway_id = local.internet_transit_gateway_id

  system = var.system

  access_from_internet = var.access_from_internet

  vpc_cidr    = var.vpc_cidr
  vpc_subnets = var.vpc_subnets

  public_additional_tgw_routes_prefix_list  = var.additional_tgw_routes_prefixlist
  private_additional_tgw_routes_prefix_list = var.additional_tgw_routes_prefixlist

  public_additional_tgw_routes  = var.additional_tgw_routes
  private_additional_tgw_routes = var.additional_tgw_routes

  route_all_private_subnets       = var.route_all_private_subnets
  private_route_table_association = var.private_route_table_association

  capella_peering_id = var.capella_peering_id
  capella_cidr_block = var.capella_cidr_block

  capella_peering_id_uat = var.capella_peering_id_uat
  capella_cidr_block_uat = var.capella_cidr_block_uat
}

module "dns" {
  source = "./dns"

  vpc_id           = module.common_network.vpc_id
  resolver_rule_id = var.resolver_rule_id
  hosted_zone_ids  = var.associated_hosted_zone_ids
}

module "ssm" {
  source = "./ssm"

  adawsread_dn       = var.adawsread_dn
  adawsread_password = var.adawsread_password
}

module "ebs_kms" {
  source                       = "./kms/ebs"
  environment                  = var.environment
  kms_cross_account_principals = var.kms_cross_account_principals
}

# module "newrelic_integration" {
#   source               = "../newrelic_integration"
#   newrelic_external_id = var.newrelic_external_id
#   environment          = var.environment
#
#   newrelic_license_key          = var.newrelic_license_key
#   newrelic_admin_key            = var.newrelic_admin_key
#   newrelic_log_ingestion_enable = var.newrelic_log_ingestion_enable
#   account_name                  = var.account_name
#
#   newrelic_metric_stream_namespaces = var.newrelic_metric_stream_namespaces
#
#   store_nr_license_key_to_secret_manager = var.store_nr_license_key_to_secret_manager
#   store_nr_license_key_to_ssm            = var.store_nr_license_key_to_ssm
# }

## experimental
# module "fis" {
#   count  = var.environment == "prod" ? 0 : 1
#   source = "./fis"
# }

module "jitna_seesion_recoring_policy" {
  source = "../iam/jitna_session_recording"
}

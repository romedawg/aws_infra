module "vpc" {
  source      = "./vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
}

module "gateways" {
  source               = "./gateways"
  vpc_id               = module.vpc.vpc_id
  access_from_internet = var.access_from_internet
}

module "az_subnets" {
  source      = "./az_subnets"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  aws_region  = var.aws_region

  vpc_subnets = var.vpc_subnets
}

module "route_tables" {
  source = "./route_tables"

  access_from_internet = var.access_from_internet

  environment = var.environment
  aws_region  = var.aws_region
  vpc_id      = module.vpc.vpc_id

  internet_gateway_id = module.gateways.internet_gateway_id

  gohealth_transit_gateway_id = var.rome_transit_gateway_id
  internet_transit_gateway_id = var.internet_transit_gateway_id

  private_prefix_list_ids = var.private_additional_tgw_routes_prefix_list
  public_prefix_list_ids  = var.public_additional_tgw_routes_prefix_list

  private_subnet_ids_by_path = local.private_subnet_ids_by_path
  public_subnet_ids_by_path  = local.public_subnet_ids_by_path

  private_additional_tgw_routes = var.private_additional_tgw_routes
  public_additional_tgw_routes  = var.public_additional_tgw_routes

  route_all_private_subnets = var.route_all_private_subnets

  private_route_table_association = var.private_route_table_association

  capella_cidr_block = var.capella_cidr_block
  capella_peering_id = var.capella_peering_id

  capella_cidr_block_uat = var.capella_cidr_block_uat
  capella_peering_id_uat = var.capella_peering_id_uat
}

module "vpc_endpoint" {
  source = "./vpc_endpoint"

  vpc_id     = module.vpc.vpc_id
  aws_region = var.aws_region

  route_table_ids = module.route_tables.route_table_ids_by_prefix

  access_from_internet = var.access_from_internet

  depends_on = [module.route_tables]
}

module "asg" {
  source          = "./asg"
  environment     = var.environment
  aws_region      = var.aws_region
  root_account_id = local.root_account_id
}

module "security" {
  source = "./security"
}

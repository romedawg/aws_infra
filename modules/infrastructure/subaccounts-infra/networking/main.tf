# Network Dependencies
module "vpc" {
  source   = "./vpc"
  vpc_cidr = var.vpc_cidr

  environment = var.environment
  system      = var.system
}

module "subnets" {
  source                 = "./subnets"
  environment            = var.environment
  system                 = var.system
  vpc_id                 = module.vpc.vpc_id
  vpc_subnet_cidr_blocks = var.vpc_subnet_cidr_blocks
  availability_zones     = local.availability_zones
}

module "gateways" {
  source                      = "./gateways"
  environment                 = var.environment
  system                      = var.system
  vpc_id                      = module.vpc.vpc_id
  public_us_east_2a_subnet_id = module.subnets.public_us_east_2a_subnet_id
  public_us_east_2b_subnet_id = module.subnets.public_us_east_2b_subnet_id
  public_us_east_2c_subnet_id = module.subnets.public_us_east_2c_subnet_id
}

module "transit_gateway" {
  source = "./tgw"
  subnet_ids = [
    module.subnets.private_us_east_2a_subnet_id,
    module.subnets.private_us_east_2b_subnet_id,
    module.subnets.private_us_east_2c_subnet_id
  ]
  vpc_id = module.vpc.vpc_id
}

module "route_tables" {
  source = "./route_tables"

  environment         = var.environment
  system              = var.system
  aws_region          = var.aws_region
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.gateways.internet_gateway_id

  public_us_east_2a_nat_gateway_id = module.gateways.public_us_east_2a_nat_gateway_id
  public_us_east_2b_nat_gateway_id = module.gateways.public_us_east_2b_nat_gateway_id
  public_us_east_2c_nat_gateway_id = module.gateways.public_us_east_2c_nat_gateway_id

  private_us_east_2a_subnet_id = module.subnets.private_us_east_2a_subnet_id
  private_us_east_2b_subnet_id = module.subnets.private_us_east_2b_subnet_id
  private_us_east_2c_subnet_id = module.subnets.private_us_east_2c_subnet_id
  public_us_east_2a_subnet_id  = module.subnets.public_us_east_2a_subnet_id
  public_us_east_2b_subnet_id  = module.subnets.public_us_east_2b_subnet_id
  public_us_east_2c_subnet_id  = module.subnets.public_us_east_2c_subnet_id
  tgw_us_east_2a_subnet_id     = module.subnets.tgw_us_east_2a_subnet_id
  tgw_us_east_2b_subnet_id     = module.subnets.tgw_us_east_2b_subnet_id
  tgw_us_east_2c_subnet_id     = module.subnets.tgw_us_east_2c_subnet_id


  rome_network_egress_tgw_id = module.transit_gateway.egress_tgw_id
}
// Creates the network topology
module "base_module" {
  source = "../infrastructure/networking/topology"

  region = var.region
}

module "alb" {
  source = "../infrastructure/networking/alb"

  default_target_group_name = "prod-drop"
  environment               = var.environment
  internal                  = "false"
  load_balancer_name        = "public-alb"
  security_groups           = [module.acl_module.alb_security_group_id]
  subnets                   = [module.base_module.public_subnet_id, module.base_module.acme_subnet_id]
  vpc                       = module.base_module.vpc_id
}

module "acl_module" {
  source      = "../infrastructure/networking/acl"
  environment = var.environment
  vpc         = module.base_module.vpc_id
}

module "iam_users" {
  source = "../infrastructure/iam/users"
}

module "ecr" {
  source = "../infrastructure/ecr"
}
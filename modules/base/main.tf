// Creates the network topology
module "base_module" {
  source = "../infrastructure/networking/topology"

  region = var.region
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
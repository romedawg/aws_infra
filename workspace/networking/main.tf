module "vpc" {
  source = "../../modules/infrastructure/networking/vpc_old_do_not_use"
}

module "security_groups" {
  source      = "../../modules/infrastructure/networking/acl"
  environment = "dev"
  vpc         = module.vpc.vpc_id
}

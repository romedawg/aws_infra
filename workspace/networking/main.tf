module "vpc" {
  source = "../../modules/infrastructure/networking/vpc"
}

module "security_groups"{
  source = "../../modules/infrastructure/networking/acl"
  environment = "dev"
  vpc = module.vpc.vpc_id
}

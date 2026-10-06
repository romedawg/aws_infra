# ./ecs-deploy service listomania latest qa --env-data /Users/rrafacz/gohealth/romans_projects/aws_infra/modules/infrastructure/ecs/romedawg/ecs-deploy-configs/terraform-testing-dev.json --svc-configs /Users/rrafacz/gohealth/romans_projects/aws_infra/modules/infrastructure/ecs/romedawg/ecs-deploy-configs/romedawg.yml --verbose -f

module "romedawg" {
  source             = "../../../modules/infrastructure/ecs/romedawg"
  vpc                = module.env.vpc_id
  environment        = local.environment
  security_group_ids = [module.base_network_topology.public_alb_security_group_id]
  subnet_ids         = [module.env.public_subnets_by_path["a___Public"],
    module.env.public_subnets_by_path["b___Public"],
    module.env.public_subnets_by_path["c___Public"]]
  aws_account_id                  = local.aws_account_id

  aws_region                      = local.aws_region
  private_hosted_zone_id = local.romedawg_com_hosted_zone_id
  private_hosted_zone_domain_name = local.romedawg_com_hosted_zone_name

}
###########################
# ECS - Container Instances
###########################
module "logrouter" {
  # This is here only because of IAM roles and service discovery.
  source = "../../../modules/services/ec2/postgres_ecs_container"
  application_name ="postgres"

  environment = "dev"
  cluster     = var.cluster

  vpc                                       = local.vpc_id
  ecs_managed_policy_arn                    = aws_iam_policy.elastic_container_service.arn
  aws_account_id                            = local.aws_account_id
  aws_region                                = local.aws_region

  key_name      = local.ssh_key_name

  iam_instance_profile_name = "dev-container_instance"

  subnets = [
    local.subnet_public_id
  ]

  ecs_cluster_name = local.environment

  ssm_agent_policy_arn = aws_iam_policy.ssm_agent_instance_policy.arn
  ami                  = "ami-0ab0629dba5ae551d"
}
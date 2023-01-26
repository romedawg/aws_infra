data "aws_iam_policy" "ecs-policy" {
  name = "${local.environment}-elastic-container-service"
}

###########################
# ECS - Container Instances
###########################
module "romedawg" {
  # This is here only because of IAM roles and service discovery.
  source           = "../../../modules/services/ec2/romedawg_com"
  application_name = "romedawg"

  environment = "dev"
  cluster     = var.cluster

  vpc                    = local.vpc_id
  ecs_managed_policy_arn = data.aws_iam_policy.ecs-policy.arn
  aws_account_id         = local.aws_account_id
  aws_region             = local.aws_region

  key_name = local.ssh_key_name

  iam_instance_profile_name = "dev-container_instance"

  subnets = [
    local.subnet_public_id
  ]

  ecs_cluster_name = local.environment

  ssm_agent_policy_arn = aws_iam_policy.ssm_agent_instance_policy.arn
  ami                  = "ami-0ab0629dba5ae551d"
  route53_zone_id      = "Z04258462YW3S2D7DVB4A"
  alb_hostname         = "public-alb-927149348.us-east-2.elb.amazonaws.com"
}
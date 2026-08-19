output "vpc_id" {
  value = module.common_network.vpc_id
}

output "ebs_kms_key" {
  value = module.ebs_kms.ebs_kms_key_arn
}

output "ecs_deploy_data" {
  value = {
    aws_account_id        = var.account_id
    aws_region            = var.aws_region
    environment           = var.environment
    log_group             = "reddog-qa"
    ecs_cluster_name      = "reddog-qa"
    docker_repository_url = "nexus-proxy.ops.gohealth.net:8082"
  }
}

output "private_subnets_by_path" {
  value = module.common_network.private_subnets_by_path
}

output "public_subnets_by_path" {
  value = module.common_network.public_subnets_by_path
}

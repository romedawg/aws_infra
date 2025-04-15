module "eks_cluster" {
  source                 = "./cluster"
  vpc_id                 = var.vpc_id
  environment            = var.environment
  cluster_security_group = var.cluster_security_group
  kubernetes_version     = var.kubernetes_version

  subnets = flatten([
    var.public_subnets,
    var.private_subnets,
  ])
}

module "eks_node_group" {
  source = "./node_group"

  cluster_name              = module.eks_cluster.name
  kubernetes_version        = module.eks_cluster.version
  release_version           = var.node_group_release_version
  environment               = var.environment
  key_name                  = var.key_name
  source_security_group_ids = var.source_security_group_ids
  subnets                   = var.private_subnets
  initial_cluster_size      = var.initial_cluster_size
  ssm_agent_policy_arn      = var.ssm_agent_policy_arn

  aws_account_id = var.aws_account_id
  aws_region     = var.aws_region
}

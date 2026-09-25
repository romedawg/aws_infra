module "astronomer" {
  source = "../../modules/infrastructure/astronomer"

  environment    = local.environment
  aws_region     = local.aws_region
  aws_account_id = local.aws_account_id

  # Networking
  vpc_id             = local.vpc_id
  private_subnet_ids = local.private_subnet_ids

  # EKS
  eks_cluster_name           = local.eks_cluster_name
  eks_node_security_group_id = local.eks_node_security_group_id
  oidc_provider_arn          = local.oidc_provider_arn
  oidc_provider_url          = local.oidc_provider_url

  # Astronomer platform
  base_domain        = local.base_domain
  admin_email        = local.admin_email
  astronomer_version = "0.34.0"

  # Database
  postgres_version         = "17"
  db_instance_class        = "db.t3.medium"
  db_allocated_storage     = 50
  db_max_allocated_storage = 200
  db_deletion_protection   = false # set true for production

  # SMTP (optional)
  smtp_enabled = false

  tags = {
    Team    = "platform"
    Project = "astronomer"
  }
}
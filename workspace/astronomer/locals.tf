locals {
  environment = "dev"
  aws_region  = "us-east-2"
  # aws_account_id = "131261850621" // Sandbox
  aws_account_id = "024441264067" // dev_testing

  # EKS cluster created by modules/infrastructure/eks
  # Update with actual cluster name from your EKS module output
  eks_cluster_name = "dev"

  # VPC and subnets - update these from your networking module outputs
  # vpc_id = "vpc-xxxxxxxxxxxxxxxxx"
  vpc_id = "vpc-054ae9fde01639567"

  private_subnet_ids = [
    "subnet-0959d5749c235194c",
    "subnet-0c5ce490142e7e79d",
    "subnet-06ded2a7f1233bc2b",
  ]

  # Security group attached to EKS worker nodes
  # From: modules/infrastructure/eks outputs
  # eks_node_security_group_id = "sg-xxxxxxxxxxxxxxxxx"
  eks_node_security_group_id = "sg-0d8494cb19356fddf"

  # OIDC provider values from EKS module outputs
  oidc_provider_arn = "arn:aws:iam::${local.aws_account_id}:oidc-provider/oidc.eks.${local.aws_region}.amazonaws.com/id/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  oidc_provider_url = "oidc.eks.${local.aws_region}.amazonaws.com/id/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

  # Astronomer platform domain
  # base_domain = "astronomer.internal.example.com"
  base_domain = "astronomer.dev.internal.gohealth.net"

  admin_email = "roman32@gmail.com"
}
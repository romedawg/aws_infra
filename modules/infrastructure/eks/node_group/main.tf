resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.environment}-${local.group_name}"
  node_role_arn   = aws_iam_role.managed_node.arn
  instance_types  = [local.instance_type]
  version         = var.kubernetes_version
  release_version = var.release_version

  subnet_ids = var.subnets

  scaling_config {
    desired_size = var.initial_cluster_size
    min_size     = var.initial_cluster_size
    max_size     = var.initial_cluster_size * 2
  }

  lifecycle {
    # Allow external changes by Cluster Autoscaler without Terraform plan difference
    ignore_changes = [scaling_config[0].desired_size]
  }

  remote_access {
    ec2_ssh_key               = var.key_name
    source_security_group_ids = var.source_security_group_ids
  }

  timeouts {
    update = "90m"
  }

  tags = {
    Name        = local.group_name
    application = local.group_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.cloudwatch_logs,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.node_policy,
    aws_iam_role_policy_attachment.container_registry_read_only_policy,
  ]
}

output "autoscaling_group" {
  # ugly... https://www.terraform.io/docs/providers/aws/r/eks_node_group.html#resources
  value = aws_eks_node_group.eks_node_group.resources[0].autoscaling_groups[0].name
}


# output "eks_node_group_autoscale_group" {
#   value = module.eks_node_group.autoscaling_group
# }

output "cluster_name" {
  value = module.eks_cluster.name
}

output "cluster_version" {
  value = module.eks_cluster.version
}

output "cluster_security_group_id" {
  value = module.eks_cluster.cluster_security_group_id
}

output "oidc_provider_arn" {
  value = module.eks_cluster.oidc_provider_arn
}

output "oidc_provider_url" {
  value = module.eks_cluster.oidc_provider_url
}


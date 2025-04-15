output "api_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "certificate_authority" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "name" {
  value = aws_eks_cluster.cluster.name
}

output "version" {
  value = aws_eks_cluster.cluster.version
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}

output "oidc_provider_url" {
  value = aws_iam_openid_connect_provider.oidc_provider.url
}

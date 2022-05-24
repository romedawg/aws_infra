output "private_dns_namespace" {
  value = aws_service_discovery_private_dns_namespace.gohealth.id
}

output "hosted_zone_id" {
  value = aws_service_discovery_private_dns_namespace.gohealth.hosted_zone
}

output "hosted_zone_domain_name" {
  value = aws_service_discovery_private_dns_namespace.gohealth.name
}


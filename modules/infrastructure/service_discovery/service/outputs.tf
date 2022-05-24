output "arn" {
  value = aws_service_discovery_service.service.arn
}

output "domain" {
  value = aws_route53_record.existing_hosted_zone_record.fqdn
}


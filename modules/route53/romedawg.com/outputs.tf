output "domain" {
  value = aws_route53_zone.romedawg_com.name
}

output "zone_id" {
  value = aws_route53_zone.romedawg_com.zone_id
}

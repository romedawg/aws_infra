output "gohealth_transit_gateway_id" {
  value = aws_ec2_transit_gateway.main.id
}

output "gohealth_transit_gateway_arn" {
  value = aws_ec2_transit_gateway.main.arn
}

output "vpc_attachment_ids" {
  value = local.vpc_attachment_ids
}
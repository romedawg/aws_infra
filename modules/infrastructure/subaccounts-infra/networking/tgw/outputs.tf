output "egress_tgw_id" {
  value = aws_ec2_transit_gateway.transit_gateway_gh_networking.id
}
output "egress_tgw_arn" {
  value = aws_ec2_transit_gateway.transit_gateway_gh_networking.arn
}

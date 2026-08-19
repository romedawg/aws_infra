output "vpc_id" {
  value = module.vpc.vpc_id
}

output "egress_tgw_arn" {
  value = module.transit_gateway.egress_tgw_arn
}

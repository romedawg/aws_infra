output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets_by_path" {
  value = local.private_subnet_ids_by_path
}

output "public_subnets_by_path" {
  value = local.public_subnet_ids_by_path
}

output "tgw_subnets_by_path" {
  value = local.tgw_subnet_ids_by_path
}

output "subnet_ids_by_path" {
  value = module.az_subnets.subnet_ids_grouped_by_path
}

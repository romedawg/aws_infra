output "romedawg_target_group" {
  value = module.romedawg.target_group_arn
}

output "security_group_id" {
  value = [module.base_network_topology.public_alb_security_group_id]
}

output "subnet_ids" {
  value = [module.env.private_subnets_by_path["a___Private"],
    module.env.private_subnets_by_path["b___Private"],
    module.env.private_subnets_by_path["c___Private"]]
}
#// acls
output "bastion_security_group_id" {
  value = module.acl_module.bastion_security_group_id
}

output "postgres_security_group_id" {
  value = module.acl_module.postgres_security_group_id
}


// Subnets IDs
output "acme_subnet_id" {
  value = module.base_module.acme_subnet_id
}

output "public_subnet_id" {
  value = module.base_module.public_subnet_id
}

// ALB Items
output "public_alb_arn" {
  value = module.alb.public_alb_arn
}

output "default_drop_target_group_arn" {
  value = module.alb.default_drop_target_group_arn
}
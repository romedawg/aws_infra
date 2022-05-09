// acls
output "bastion_security_group" {
  value = module.acl_module.bastion_security_group
}


// Subnets IDs
output "acme_subnet_id" {
  value = module.base_module.acme_subnet_id
}

output "public_subnet_id" {
  value = module.base_module.public_subnet_id
}


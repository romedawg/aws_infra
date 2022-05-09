output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

// Subnet Info
output "public_subnet_id" {
  value = module.subnets.public_subnet_id
}


output "acme_subnet_id" {
  value = module.subnets.acme_subnet_id
}
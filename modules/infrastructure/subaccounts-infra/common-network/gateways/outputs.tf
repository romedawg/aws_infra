output "internet_gateway_id" {
  value = one(aws_internet_gateway.igw[*].id)
}

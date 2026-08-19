output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "public_us_east_2a_nat_gateway_id" {
  value = aws_nat_gateway.public_us_east_2a_nat_gateway.id
}

output "public_us_east_2b_nat_gateway_id" {
  value = aws_nat_gateway.public_us_east_2b_nat_gateway.id
}

output "public_us_east_2c_nat_gateway_id" {
  value = aws_nat_gateway.public_us_east_2c_nat_gateway.id
}

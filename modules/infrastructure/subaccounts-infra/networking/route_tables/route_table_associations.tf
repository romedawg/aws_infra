resource "aws_route_table_association" "tgw_nat_gateway_one_table_private_one_association" {
  route_table_id = aws_route_table.private_table_2a.id
  subnet_id      = var.private_us_east_2a_subnet_id
}

resource "aws_route_table_association" "tgw_nat_gateway_one_table_private_two_association" {
  route_table_id = aws_route_table.private_table_2b.id
  subnet_id      = var.private_us_east_2b_subnet_id
}

resource "aws_route_table_association" "tgw_nat_gateway_one_table_private_three_association" {
  route_table_id = aws_route_table.private_table_2c.id
  subnet_id      = var.private_us_east_2c_subnet_id
}

resource "aws_route_table_association" "igw_table_public_2a_association" {
  route_table_id = aws_route_table.public_table_2a.id
  subnet_id      = var.public_us_east_2a_subnet_id
}

resource "aws_route_table_association" "igw_table_public_2b_association" {
  route_table_id = aws_route_table.public_table_2b.id
  subnet_id      = var.public_us_east_2b_subnet_id
}

resource "aws_route_table_association" "igw_table_public_2c_association" {
  route_table_id = aws_route_table.public_table_2c.id
  subnet_id      = var.public_us_east_2c_subnet_id
}
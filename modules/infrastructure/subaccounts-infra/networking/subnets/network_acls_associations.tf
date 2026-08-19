resource "aws_network_acl_association" "nacl_assignment_private_us_east_2a" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.private_us_east_2a.id
}

resource "aws_network_acl_association" "nacl_assignment_private_us_east_2b" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.private_us_east_2b.id
}

resource "aws_network_acl_association" "nacl_assignment_private_us_east_2c" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.private_us_east_2c.id
}

resource "aws_network_acl_association" "nacl_assignment_public_us_east_2a" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.public_us_east_2a.id
}

resource "aws_network_acl_association" "nacl_assignment_public_us_east_2b" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.public_us_east_2b.id
}

resource "aws_network_acl_association" "nacl_assignment_public_us_east_2c" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.public_us_east_2c.id
}

resource "aws_network_acl_association" "nacl_assignment_tgw_us_east_2a" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.tgw_us_east_2a.id
}

resource "aws_network_acl_association" "nacl_assignment_tgw_us_east_2b" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.tgw_us_east_2b.id
}

resource "aws_network_acl_association" "nacl_assignment_tgw_us_east_2c" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.tgw_us_east_2c.id
}
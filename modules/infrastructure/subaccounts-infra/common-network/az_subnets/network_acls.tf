resource "aws_network_acl" "nacl" {
  vpc_id = var.vpc_id
}

resource "aws_network_acl_rule" "private_all_egress" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 1000
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "private_all_ingress" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 1010
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

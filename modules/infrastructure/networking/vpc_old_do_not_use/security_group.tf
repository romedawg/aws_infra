//resource "aws_security_group" "bastion" {
//  name        = "bastion"
//  description = "Allow SSH access to the bastion node from whitelist source IP"
//  vpc_id      = aws_vpc.vpc_old_do_not_use.id
//
//  ingress {
//    from_port   = 22
//    to_port     = 22
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/32"]
//  }
//
//  egress {
//    from_port   = 0
//    to_port     = 0
//    protocol    = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  tags = {
//    application = "bastion"
//  }
//}
//

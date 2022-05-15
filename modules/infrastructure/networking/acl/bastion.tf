resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow SSH access to the bastion node from whitelist source IP"
  vpc_id      = var.vpc

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["24.15.4.0/24", "10.50.0.0/16"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["24.15.4.0/24"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["24.15.4.0/24"]
  }

  tags = {
    application = "bastion"
  }
}


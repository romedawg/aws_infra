resource "aws_security_group" "postgres" {
  name        = "postgres"
  description = "Allow SSH/postgress access to the posgres node from whitelisted CIDR block"
  vpc_id      = var.vpc

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = local.rome_network
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = local.rome_network
  }

  tags = {
    application = "postgres"
  }
}


resource "aws_security_group" "postgres" {
  name        = "postgres"
  description = "Allow SSH/postgress access to the posgres node from whitelisted CIDR block"
  vpc_id      = var.vpc

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.50.0.0/16"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.50.0.0/16"]
  }

  tags = {
    application = "postgres"
  }
}


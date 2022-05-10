resource "aws_security_group" "alb-public" {
  name        = "public-alv"
  description = "Allow 80/443 routing to the public alb"
  vpc_id      = var.vpc


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    application = "alb-public"
    environment = var.environment
  }
}


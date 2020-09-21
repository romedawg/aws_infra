resource "aws_security_group" "postgres_rds" {
  name        = "${var.environment}-postgres-rds"
  description = "Allow inbound connections to a Postgres RDS"
  vpc_id      = var.vpc

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = [
      aws_security_group.eks_cluster.id,
    ]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  }

  tags = {
    application = "postgres"
    environment = var.environment
  }
}


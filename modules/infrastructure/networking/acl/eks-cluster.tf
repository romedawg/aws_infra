resource "aws_security_group" "eks_cluster" {
  name        = "qa-eks-cluster"
  description = "This defines network access to the EKS control plane, including the API server."
  vpc_id      = var.vpc


  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }


  tags = {
    application = "elastic-kubernetes-service"
    environment = var.environment
  }
}

locals {
  private_dns_namespace_name = "${var.environment}-svc"
}

resource "aws_service_discovery_private_dns_namespace" "gohealth" {
  name = local.private_dns_namespace_name
  vpc  = var.vpc
}


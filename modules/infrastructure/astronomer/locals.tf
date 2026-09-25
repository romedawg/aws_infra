locals {
  name_prefix = "astronomer-${var.environment}"

  cidr_blocks = ["10.0.0.0/8"]
  cidr_blocks_egress_output = ["0.0.0.0/0"]
  common_tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "terraform"
    Application = "astronomer"
  })

  # Strip https:// from OIDC URL if present
  oidc_provider_url = replace(var.oidc_provider_url, "https://", "")
}
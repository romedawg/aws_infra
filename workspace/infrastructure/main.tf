# Network topology, Subnets, ACLS, etc.. all things networking
module "base_network_topology" {
  source      = "../../modules/base"
  environment = local.environment
}

# Route53 items
module "romedawg_route53" {
  source = "../../modules/infrastructure/route53"
}

#  Mail server
module "romedawg_ses" {
  source  = "../../modules/ses"
  domain  = module.romedawg_route53.domain
  zone_id = module.romedawg_route53.zone_id
}

module "romedawg_ec2" {
  source         = "../../modules/services/romedawg.com"
  aws_account_id = local.account_id
  aws_region     = local.region
  environment    = "dev"
  key_name       = "romedawg"
  security_group = module.base_network_topology.bastion_security_group
  subnet         = module.base_network_topology.acme_subnet_id
  zone_id        = module.romedawg_route53.zone_id
}

// Certificate creation
resource "aws_s3_bucket" "cert_bucket" {
  bucket = "certs19292912"
  acl    = "private"

  tags = {
    Name = "certs"
  }
}

module "acme-account-registration" {
  source             = "../../modules/lets_encrypt/acme-account-registration"
  registration_email = "roman32@gmail.com"
  server_url         = "https://acme-v02.api.letsencrypt.org/directory"
}

module "acme-cert-request" {
  source          = "../../modules/lets_encrypt/acme-cert-request"
  account_key_pem = module.acme-account-registration.account_key_pem
  server_url      = "https://acme-v02.api.letsencrypt.org/directory"

  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
  region                = local.region
}

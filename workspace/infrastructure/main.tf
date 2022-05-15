# Network topology, Subnets, ACLS, etc.. all things networking
module "base_network_topology" {
  source      = "../../modules/base"
  environment = local.environment
  region = local.region
  certificate_arn = module.import_romedawg_acm.romedawg_certificate_arn
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

#######################
# EC2 INSTANCES
#######################
# POSTGRES server
#module "postgres" {
#  source = "../../modules/services/postgres"
#
#  availability_zone_2a_metadata = {
#      subnet_id = module.base_network_topology.public_subnet_id,
#      zone_id = "us-east-2a" }
#  aws_account_id                = local.account_id
#  aws_region                    = local.region
#  private_hosted_zone_id       = module.romedawg_route53.zone_id
#  key_name                      = "roman_aws"
#  security_group                = module.base_network_topology.postgres_security_group_id
#}
#
#
## This is used to renew romedawg.com certificate
#module "romedawg_ec2" {
#  source         = "../../modules/services/romedawg.com"
#  aws_account_id = local.account_id
#  aws_region     = local.region
#  environment    = "dev"
#  key_name       = "roman_aws"
#  security_group = module.base_network_topology.bastion_security_group_id
#  subnet         = module.base_network_topology.acme_subnet_id
#  zone_id        = module.romedawg_route53.zone_id
#}


#######################
# Certificates
#######################

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

module "import_romedawg_acm" {
  source = "../../modules/certificates"

  certificate_body  = module.acme-cert-request.certificate
  certificate_chain = module.acme-cert-request.issuer_pem
  domain_name       = module.acme-cert-request.domain
  private_key       = module.acme-cert-request.private_key_pem
}
# Network topology, Subnets, ACLS, etc.. all things networking
module "base_network_topology" {
  source = "../../modules/base"
}



# Route53 items
module "romedawg_route53" {
  source = "../../modules/infrastructure/route53"
}

#
#module "romedawg_ses" {
#  source  = "../../modules/ses"
#  domain  = module.romedawg_route53.domain
#  zone_id = module.romedawg_route53.zone_id
#}
#
#module "vpc" {
#  source = "../../modules/networking/vpc"
#}
#
#module "security_groups"{
#  source = "../../modules/networking/acl"
#  environment = "dev"
#  vpc = module.vpc.vpc_id
#}
#
#module "romedawg_ec2" {
#  source = "../../modules/services/romedawg.com"
#  aws_account_id = local.account_id
#  aws_region = local.region
#  environment = "dev"
#  key_name = "rome"
#  security_group = module.security_groups.bastion_security_group
#  subnet = module.vpc.data_one_subnet
#  zone_id = module.romedawg_route53.zone_id
#}

// ec2/network working
// next step.
// httpd started
// romedawg.com certs installed.


#// Certificate creation
#resource "aws_s3_bucket" "cert_bucket" {
#  bucket = "certs19292912"
#  acl    = "private"
#
#  tags = {
#    Name        = "certs"
#  }
#}
#
#module "acme-account-registration" {
#  source             = "../../modules/lets_encrypt/acme-account-registration"
#  registration_email = "roman32@gmail.com"
#  server_url         = "https://acme-v02.api.letsencrypt.org/directory"
#}
#
#module "acme-cert-request" {
#  source          = "../../modules/lets_encrypt/acme-cert-request"
#  account_key_pem = module.acme-account-registration.account_key_pem
#  server_url         = "https://acme-v02.api.letsencrypt.org/directory"
#}

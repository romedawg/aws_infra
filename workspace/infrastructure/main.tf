# Network topology, Subnets, ACLS, etc.. all things networking
module "base_network_topology" {
  source      = "../../modules/base"
  environment = local.environment
  region      = local.aws_region
}

#######################
# ECS Cluster
#######################
module "ecs_cluster" {
  source = "../../modules/infrastructure/ecs/cluster"
}

# Route53 items
module "romedawg_route53" {
  source = "../../modules/infrastructure/route53"
}

#######################
# Create ALB Items
#######################
module "alb" {
  source = "../../modules/infrastructure/networking/alb"

  default_target_group_name = "prod-drop"
  environment               = local.environment
  internal                  = "false"
  load_balancer_name        = "public-alb"
  security_groups           = [module.base_network_topology.public_alb_security_group_id]
  subnets                   = [module.base_network_topology.public_subnet_id, module.base_network_topology.acme_subnet_id]
  vpc                       = module.base_network_topology.vpc_id
}


##  Mail server
#module "romedawg_ses" {
#  source  = "../../modules/services/ses"
#  domain  = module.romedawg_route53.domain
#  zone_id = module.romedawg_route53.zone_id
#}

#######################
# Certificates
#######################
#module "lets_encrypt_cert" {
#  source                = "../../modules/services/lets_encrypt_certs"
#  registrant_email      = "roman32@gmail.com"
#  server_url            = "https://acme-v02.api.letsencrypt.org/directory"
#  aws_access_key_id     = var.aws_access_key_id
#  aws_secret_access_key = var.aws_secret_access_key
#  region                = local.aws_region
#  domain                = "romedawg.com"
#}
#
#module "import_romedawg_acm" {
#  source = "../../modules/certificates"
#
#  certificate_body  = module.lets_encrypt_cert.certificate
#  certificate_chain = module.lets_encrypt_cert.certificate_chain
#  domain_name       = module.lets_encrypt_cert.domain_name
#  private_key       = module.lets_encrypt_cert.private_key
#}


#
### Now we can create ALB Listener, Cert created above
#module "alb_listener" {
#  source = "../../modules/infrastructure/networking/alb/alb_listener"
#
#  alb_arn          = module.alb.public_alb_arn
#  certificate_arn  = module.import_romedawg_acm.romedawg_certificate_arn
#  default_drop_arn = module.alb.default_drop_target_group_arn
#}














#######################
# EC2 INSTANCES
#######################
# POSTGRES server
#module "postgres" {
#  source = "../../modules/services/ec2/postgres"
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
### This is used to renew romedawg.com certificate
#module "romedawg_ec2" {
#  source         = "../../modules/services/ec2/romedawg.com"
#  aws_account_id = local.account_id
#  aws_region     = local.region
#  environment    = "dev"
#  key_name       = "roman_aws"
#  security_group = module.base_network_topology.bastion_security_group_id
#  subnet         = module.base_network_topology.acme_subnet_id
#  zone_id        = module.romedawg_route53.zone_id
#}


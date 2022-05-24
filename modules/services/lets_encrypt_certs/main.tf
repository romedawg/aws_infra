module "acme-account-registration" {
  source             = "./acme-account-registration"
  registration_email = var.registrant_email
  server_url         = var.server_url
}

module "acme-cert-request" {
  source          = "./acme-cert-request"
  account_key_pem = module.acme-account-registration.account_key_pem
  server_url      = var.server_url

  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
  region                = var.region
  domain                = var.domain
}
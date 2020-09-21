# ----------------------------------------------------------------
# Inputs required to do an initial registration (aka create an
# account) with the ACME provider (Let's Encrypt)
# ----------------------------------------------------------------
provider "acme" {
  server_url = var.server_url
}

resource "tls_private_key" "acme_registration_private_key" {
  algorithm = "RSA"
}

# Set up a registration using the registration private key
resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.acme_registration_private_key.private_key_pem
  email_address   = var.registration_email
}

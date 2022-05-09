provider "acme" {
  server_url = var.server_url
}

resource "tls_private_key" "certificate_private_key" {
  algorithm = "RSA"
}

resource "tls_cert_request" "tls_certificate_request" {
  key_algorithm = "RSA"
  private_key_pem = tls_private_key.certificate_private_key.private_key_pem
  subject { common_name = "romedawg.com" }
  dns_names = ["*.romedawg.com"]
}

resource "acme_certificate" "create_certificate" {
  account_key_pem = var.account_key_pem
  //  account_key_pem = acme_registration.registration.account_key_pem
  certificate_request_pem = tls_cert_request.tls_certificate_request.cert_request_pem

  dns_challenge {
    provider = "route53"

    config = {
      AWS_ACCESS_KEY_ID     = var.aws_access_key_id
      AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
      AWS_DEFAULT_REGION    = var.region
    }
  }
}

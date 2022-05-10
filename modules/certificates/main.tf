resource "aws_acm_certificate" "cert_import_romedawg" {

  private_key = var.private_key
  certificate_body = var.certificate_body
  certificate_chain = var.certificate_chain

  tags = {
    domain = var.domain_name
  }

  lifecycle {
    create_before_destroy = true
  }
}


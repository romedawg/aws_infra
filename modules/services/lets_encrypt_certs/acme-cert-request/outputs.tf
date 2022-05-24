output "certificate" {
  value = acme_certificate.create_certificate.certificate_pem
}

output "issuer_pem" {
  value = acme_certificate.create_certificate.issuer_pem
}

output "subject_alternative_names" {
  value = acme_certificate.create_certificate.subject_alternative_names
}

output "domain" {
  value = acme_certificate.create_certificate.certificate_domain
}

output "private_key_pem" {
  value = tls_private_key.certificate_private_key.private_key_pem
}
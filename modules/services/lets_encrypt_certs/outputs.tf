output "certificate" {
  value = module.acme-cert-request.certificate
}

output "certificate_chain" {
  value = module.acme-cert-request.issuer_pem
}

output "domain_name" {
  value = module.acme-cert-request.domain
}

output "private_key" {
  value = module.acme-cert-request.private_key_pem
}
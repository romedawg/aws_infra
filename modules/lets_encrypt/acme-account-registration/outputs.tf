# ------------------------------------------
# Outputs required for use in other modules
# ------------------------------------------

output "account_key_pem" {
  value = acme_registration.registration.account_key_pem
}

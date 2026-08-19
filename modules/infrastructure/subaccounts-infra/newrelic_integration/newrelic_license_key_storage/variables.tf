variable "newrelic_license_key" {
  description = "NewRelic license key to be stored in secret manager."
}

variable "store_nr_license_key_to_secret_manager" {
  description = "Flag whether to store new relic license key in secret manager"
  default     = false
}

variable "store_nr_license_key_to_ssm" {
  description = "Flag whether to store new relic license key in ssm parameter store"
  default     = false
}

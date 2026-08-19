variable "environment" {}
variable "newrelic_external_id" {}
variable "newrelic_log_ingestion_enable" {
  default = false
}

variable "newrelic_license_key" {
  description = "NewRelic license key to be used for log ingestion. Empty = no log ingestion is created."
}

variable "newrelic_admin_key" {
  description = "NewRelic admin key for newrelic setup."
}

variable "account_name" {}

variable "role_name_override" {
  default = ""
}

variable "store_nr_license_key_to_secret_manager" {
  description = "Flag whether to store new relic license key in secret manager"
  default     = false
}

variable "store_nr_license_key_to_ssm" {
  description = "Flag whether to store new relic license key in ssm parameter store"
  default     = false
}

variable "newrelic_metric_stream_namespaces" {
  type    = list(string)
  default = []
}

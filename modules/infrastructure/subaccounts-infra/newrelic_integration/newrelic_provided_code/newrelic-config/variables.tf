variable "newrelic_account_id" {
  type = string
}

variable "newrelic_account_region" {
  type    = string
  default = "US"

  validation {
    condition     = contains(["US", "EU"], var.newrelic_account_region)
    error_message = "Valid values for region are 'US' or 'EU'."
  }
}

variable "name" {
  type = string
}

variable "nr_admin_key" {
  type        = string
  description = "Your NewRelic license key."
  sensitive   = true
}

variable "role_name_override" {
  type = string
}

variable "newrelic_metric_stream_namespaces" {
  type    = list(string)
  default = []
}

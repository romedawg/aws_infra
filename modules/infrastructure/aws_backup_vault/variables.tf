variable "kms_key_arn" {}

variable "changeable_for_days" {
  default = null
}

variable "environment" {}

variable "max_retention_days" {}

variable "min_retention_days" {}

variable "service" {}

variable "source_account_id" {
  description = "AWS Account ID that is going to copy backups into this vault"
  default     = ""
}

variable "organization_id" {
  description = "AWS Organization ID"
  default     = ""
}

variable "vault_name" {}

variable "create_vault_lock" {}
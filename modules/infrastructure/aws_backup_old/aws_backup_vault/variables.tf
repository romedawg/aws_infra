variable "vault_service_name" {}
variable "kms_key_arn" {}
variable "source_account_id" {
  description = "AWS Account ID that is going to copy backups into this vault"
}
variable "changeable_for_days" {
  default = null
}
variable "max_retention_days" {}
variable "min_retention_days" {}

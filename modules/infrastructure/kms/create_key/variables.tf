variable "key_name" {}
variable "service_name" {}
variable "shared_accounts" {
  default     = []
  description = "Comma separated list of accounts that should have access to this key"
  type        = list(string)
}
variable "deletion_windows_days" {
  default = 30
}

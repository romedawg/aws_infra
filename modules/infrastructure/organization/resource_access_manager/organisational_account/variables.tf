variable "account_id" {}

variable "associated_resource_arns" {
  type = map(string)
}

variable "is_external_account" {
  type = bool

  default = false
}

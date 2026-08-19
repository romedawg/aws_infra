
variable "transit_gateway_arn" {}

variable "managed_prefix_arns" {
  type = map(string)
}

variable "managed_organization_accounts" {
  type = map(object({
    account_id = string
    ad_group   = string
  }))
}

variable "subaccount_tgw_attachments" {
  type = list(string)
}

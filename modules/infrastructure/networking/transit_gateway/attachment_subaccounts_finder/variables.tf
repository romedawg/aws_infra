
variable "managed_organization_accounts" {
  type = map(object({
    account_id = string
    ad_group   = string
  }))
}

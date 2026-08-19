output "account_info" {
  value = {
    (aws_organizations_account.account.name) = {
      account_id      = aws_organizations_account.account.id
      ad_group        = var.administrator_ad_group
      share_resources = var.share_resources
    }
  }
}
output "account_info" {
  value = {
    (var.account_name) = {
      account_id      = var.account_id
      ad_group        = var.administrator_ad_group
      share_resources = var.share_resources
    }
  }
}

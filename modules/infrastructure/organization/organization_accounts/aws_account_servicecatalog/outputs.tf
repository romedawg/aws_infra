output "account_info" {
  value = {
    (aws_servicecatalog_provisioned_product.account.name) = {
      account_id      = local.account_id
      ad_group        = var.administrator_ad_group
      share_resources = var.share_resources
    }
  }
}

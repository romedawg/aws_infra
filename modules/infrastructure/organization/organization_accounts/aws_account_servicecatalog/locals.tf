locals {
  account_id = [for out in aws_servicecatalog_provisioned_product.account.outputs : out.value if out.key == "AccountId"][0]
}

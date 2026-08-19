resource "aws_ram_resource_share" "ram_share" {
  name                      = "ram-${var.account_id}"
  allow_external_principals = var.is_external_account
}

resource "aws_ram_principal_association" "ram_principal_association" {
  resource_share_arn = aws_ram_resource_share.ram_share.arn
  principal          = var.account_id
}

resource "aws_ram_resource_association" "ram_resource_association" {
  for_each           = var.associated_resource_arns
  resource_share_arn = aws_ram_resource_share.ram_share.arn
  resource_arn       = each.value
}

resource "aws_ram_resource_share" "ram_share" {
  for_each                  = toset(var.sub_account_ids)
  name                      = "ram-tgw-${each.key}"
  allow_external_principals = false

  tags = {
    Name = "gh-network-tgw-share"
  }
}

resource "aws_ram_principal_association" "ram_principal_association" {
  for_each           = toset(var.sub_account_ids)
  resource_share_arn = aws_ram_resource_share.ram_share[each.key].arn
  principal          = each.key
}

resource "aws_ram_resource_association" "ram_resource_association" {
  for_each           = toset(var.sub_account_ids)
  resource_share_arn = aws_ram_resource_share.ram_share[each.key].arn
  resource_arn       = var.egress_tgw_arn
}
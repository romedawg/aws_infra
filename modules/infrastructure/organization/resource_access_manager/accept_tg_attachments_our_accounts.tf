resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "accepter_our_accounts" {
  for_each = toset(var.subaccount_tgw_attachments)

  transit_gateway_attachment_id = each.value
}

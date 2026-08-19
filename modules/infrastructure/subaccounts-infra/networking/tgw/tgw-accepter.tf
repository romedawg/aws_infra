data "aws_ec2_transit_gateway_vpc_attachments" "filtered" {
  filter {
    name   = "state"
    values = ["pendingAcceptance", "available", "pending"]
  }
  filter {
    name   = "transit-gateway-id"
    values = [aws_ec2_transit_gateway.transit_gateway_gh_networking.id]
  }
}

data "aws_ec2_transit_gateway_vpc_attachment" "attachments" {
  count = length(data.aws_ec2_transit_gateway_vpc_attachments.filtered.ids)
  id    = data.aws_ec2_transit_gateway_vpc_attachments.filtered.ids[count.index]
}

locals {
  attachments_map = {
    for v in data.aws_ec2_transit_gateway_vpc_attachment.attachments :
    v.id => v.id
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "accepter_our_accounts" {
  for_each                      = local.attachments_map
  transit_gateway_attachment_id = each.value

  lifecycle {
    ignore_changes = [tags]
  }
}


data "aws_ec2_transit_gateway_vpc_attachments" "all_attachments" {
  filter {
    name   = "state"
    values = ["pendingAcceptance", "available", "pending"]
  }
}

data "aws_ec2_transit_gateway_vpc_attachment" "one_attachment" {
  count = length(data.aws_ec2_transit_gateway_vpc_attachments.all_attachments.ids)
  id    = data.aws_ec2_transit_gateway_vpc_attachments.all_attachments.ids[count.index]
}

locals {
  managed_account_ids = [for k, oa in var.managed_organization_accounts : oa.account_id]
}

output "tgw_attachment_ids" {
  value = [for pe in data.aws_ec2_transit_gateway_vpc_attachment.one_attachment : pe.id
    if contains(local.managed_account_ids, pe.vpc_owner_id)
  ]
}

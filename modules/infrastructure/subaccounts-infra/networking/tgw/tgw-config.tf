resource "aws_ec2_transit_gateway" "transit_gateway_gh_networking" {
  description = "networking_tgw"
  tags = {
    Name = "gh-network-egress"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "egress_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway_gh_networking.id
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  dns_support        = "enable"

  transit_gateway_default_route_table_association = "true"
  transit_gateway_default_route_table_propagation = "true"

  tags = {
    Name = "gh-network-egress"
  }
}

resource "aws_ec2_transit_gateway_route" "wildcard_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.egress_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.transit_gateway_gh_networking.association_default_route_table_id
}

resource "aws_ram_resource_share" "gh_tgw_ram_share" {

  name                      = "gh-network-tgw-share"
  allow_external_principals = false

  tags = {
    Name = "gh-network-tgw-share"
  }
}


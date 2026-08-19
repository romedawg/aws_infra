resource "aws_ec2_transit_gateway" "main" {
  description = "transit gateway for all AWS VPN traffic"
  # amazon_side_asn = local.customer_gateway_bgp_asn["amazon_asn"]
  dns_support = "enable"

  tags = {
    Name = "main-tgw"
  }

  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  auto_accept_shared_attachments  = "disable"
}

// main vpc in main/root account
module "ops_vpc_attachment" {
  source = "./attachments/vpc"

  transit_gateway_id = aws_ec2_transit_gateway.main.id
  subnet_ids         = local.ops_subnet_ids
  environment        = "ops"
  vpc_id             = local.vpc_id["ops"]
}
resource "aws_ec2_transit_gateway_vpc_attachment" "rome" {
  transit_gateway_id = var.rome_transit_gateway_id
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = values(local.tgw_subnet_ids_by_path)
  dns_support        = "enable"

  transit_gateway_default_route_table_association = "true"
  transit_gateway_default_route_table_propagation = "true"

  tags = {
    Name   = "${var.system}-${var.environment}"
    prefix = "Private"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "internet" {
  transit_gateway_id = var.internet_transit_gateway_id
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = values(local.tgw_subnet_ids_by_path)
  dns_support        = "enable"

  transit_gateway_default_route_table_association = "true"
  transit_gateway_default_route_table_propagation = "true"

  tags = {
    Name   = "${var.system}-${var.environment}"
    prefix = "Public"
  }
}

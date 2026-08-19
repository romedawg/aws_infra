resource "aws_ec2_transit_gateway_vpc_attachment" "vpc" {
  transit_gateway_id                              = var.transit_gateway_id
  vpc_id                                          = var.vpc_id
  subnet_ids                                      = var.subnet_ids
  dns_support                                     = "enable"
  transit_gateway_default_route_table_association = "true"
  transit_gateway_default_route_table_propagation = "true"

  tags = {
    Name        = "vpc-attachment"
    environment = var.environment
  }
}


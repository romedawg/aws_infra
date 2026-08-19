resource "aws_route_table" "private_table_2a" {

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.public_us_east_2a_nat_gateway_id
  }

  dynamic "route" {
    for_each = local.private_ip_ranges
    content {
      cidr_block         = route.value
      transit_gateway_id = var.rome_network_egress_tgw_id
    }
  }

  tags = {
    Name = "TGW-PrivateRouteTableUsEast2a"
  }

  vpc_id = var.vpc_id
}


resource "aws_route_table" "private_table_2b" {

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.public_us_east_2b_nat_gateway_id
  }

  dynamic "route" {
    for_each = local.private_ip_ranges
    content {
      cidr_block         = route.value
      transit_gateway_id = var.rome_network_egress_tgw_id
    }
  }

  tags = {
    Name = "TGW-PrivateRouteTableUsEast2b"
  }

  vpc_id = var.vpc_id
}

resource "aws_route_table" "private_table_2c" {

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.public_us_east_2c_nat_gateway_id
  }

  dynamic "route" {
    for_each = local.private_ip_ranges
    content {
      cidr_block         = route.value
      transit_gateway_id = var.rome_network_egress_tgw_id
    }
  }

  tags = {
    Name = "TGW-PrivateRouteTableUsEast2c"
  }

  vpc_id = var.vpc_id
}

resource "aws_route_table" "public_table_2a" {

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  dynamic "route" {
    for_each = local.private_ip_ranges
    content {
      cidr_block         = route.value
      transit_gateway_id = var.rome_network_egress_tgw_id
    }
  }

  tags = {
    Name = "${var.system}-${var.environment}-PublicRouteTableUsEast2a"
  }

  vpc_id = var.vpc_id
}


resource "aws_route_table" "public_table_2b" {

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  dynamic "route" {
    for_each = local.private_ip_ranges
    content {
      cidr_block         = route.value
      transit_gateway_id = var.rome_network_egress_tgw_id
    }
  }

  tags = {
    Name = "${var.system}-${var.environment}-PublicRouteTableUsEast2b"
  }

  vpc_id = var.vpc_id
}

resource "aws_route_table" "public_table_2c" {

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  dynamic "route" {
    for_each = local.private_ip_ranges
    content {
      cidr_block         = route.value
      transit_gateway_id = var.rome_network_egress_tgw_id
    }
  }

  tags = {
    Name = "${var.system}-${var.environment}-PublicRouteTableUsEast2c"
  }

  vpc_id = var.vpc_id
}

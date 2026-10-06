resource "aws_route_table" "private_table" {
  # dynamic "route" {
  #   for_each = toset(var.private_prefix_list_ids)
  #   content {
  #     destination_prefix_list_id = route.key
  #     transit_gateway_id         = var.gohealth_transit_gateway_id
  #   }
  # }
  #
  # dynamic "route" {
  #   for_each = toset(var.private_additional_tgw_routes)
  #   content {
  #     cidr_block         = route.key
  #     transit_gateway_id = var.gohealth_transit_gateway_id
  #   }
  # }
  #
  # dynamic "route" {
  #   for_each = var.route_all_private_subnets ? local.private_ip_ranges : []
  #   content {
  #     cidr_block         = route.value
  #     transit_gateway_id = var.gohealth_transit_gateway_id
  #   }
  # }

  dynamic "route" {
    for_each = var.internet_transit_gateway_id != null ? [1] : []
    content {
      cidr_block         = "0.0.0.0/0"
      transit_gateway_id = var.internet_transit_gateway_id
    }
  }

  dynamic "route" {
    for_each = var.internet_transit_gateway_id == null ? [0] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = "nat-10e165a0bb0dcde44"
    }
  }

  tags = {
    Name = "PrivateRouteTable"
  }

  vpc_id = var.vpc_id
}

resource "aws_route_table" "public_table" {
  count = var.access_from_internet ? 1 : 0
  dynamic "route" {
    for_each = toset(var.public_prefix_list_ids)
    content {
      destination_prefix_list_id = route.key
      transit_gateway_id         = var.gohealth_transit_gateway_id
    }
  }

  dynamic "route" {
    for_each = toset(var.public_additional_tgw_routes)
    content {
      cidr_block         = route.key
      transit_gateway_id = var.gohealth_transit_gateway_id
    }
  }

  dynamic "route" {
    for_each = var.route_all_private_subnets ? local.private_ip_ranges : []
    content {
      cidr_block         = route.value
      transit_gateway_id = var.gohealth_transit_gateway_id
    }
  }

  dynamic "route" {
    for_each = var.internet_gateway_id != null ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = var.internet_gateway_id
    }
  }

  tags = {
    Name = "PublicRouteTable"
  }

  vpc_id = var.vpc_id
}

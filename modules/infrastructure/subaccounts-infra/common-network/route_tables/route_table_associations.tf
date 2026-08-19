data "aws_route_tables" "private_table" {
  filter {
    name   = "tag:Name"
    values = ["PrivateRouteTable"]
  }
}

data "aws_route_tables" "public_table" {
  filter {
    name   = "tag:Name"
    values = ["PublicRouteTable"]
  }
}

resource "aws_route_table_association" "private_table_association" {
  for_each       = length(data.aws_route_tables.private_table.ids) > 0 ? var.private_subnet_ids_by_path : {}
  route_table_id = data.aws_route_tables.private_table.ids[0]
  subnet_id      = each.value
}

resource "aws_route_table_association" "public_table_association" {
  for_each       = length(data.aws_route_tables.public_table.ids) > 0 ? var.public_subnet_ids_by_path : {}
  route_table_id = data.aws_route_tables.public_table.ids[0]
  subnet_id      = each.value
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.s3"
}

data "aws_route_tables" "routes" {
  vpc_id = var.vpc_id
}

resource "aws_vpc_endpoint_route_table_association" "s3_vpc_endpoint_route_table_association" {
  for_each        = { for type, id in var.route_table_ids : type => id if(!(type == "public" && !var.access_from_internet)) }
  route_table_id  = each.value
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

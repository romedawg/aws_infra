output "route_table_ids" {
  value = [
    aws_route_table.private_table_2a.id,
    aws_route_table.private_table_2b.id,
    aws_route_table.private_table_2c.id,
    aws_route_table.public_table_2a.id,
    aws_route_table.public_table_2b.id,
  aws_route_table.public_table_2c.id]
}

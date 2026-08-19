output "private_route_table_ids" {
  value = [one(aws_route_table.private_table[*].id)]
}

output "public_route_table_ids" {
  value = [one(aws_route_table.public_table[*].id)]
}

output "route_table_ids_by_prefix" {
  value = {
    private : one(aws_route_table.private_table[*].id)
    public : length(aws_route_table.public_table) > 0 ? one(aws_route_table.public_table[*].id) : null
  }
}

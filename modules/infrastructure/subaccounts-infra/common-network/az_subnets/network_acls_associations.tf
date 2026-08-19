resource "aws_network_acl_association" "nacl_assignment" {
  for_each       = local.subnet_ids_by_path
  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = each.value
}

resource "aws_subnet" "subnet" {
  for_each   = { for k, v in var.subnets : k => v if v != null }
  vpc_id     = var.vpc_id
  cidr_block = each.value

  availability_zone = local.full_zone

  tags = {
    Name        = "${title(each.key)}${local.zone_titled}"
    Environment = var.environment
    prefix      = each.key
    zone        = var.zone
  }
}

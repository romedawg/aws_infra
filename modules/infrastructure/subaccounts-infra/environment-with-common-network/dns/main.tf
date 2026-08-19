resource "aws_route53_resolver_rule_association" "vpc_resolver_rule_association" {
  resolver_rule_id = var.resolver_rule_id
  vpc_id           = var.vpc_id
}

resource "aws_route53_zone_association" "hosted_zones_associations" {
  for_each = toset(var.hosted_zone_ids)
  vpc_id   = var.vpc_id
  zone_id  = each.key
}

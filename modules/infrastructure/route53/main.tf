resource "aws_route53_delegation_set" "romedawg_com" {
  reference_name = "romedawgNS"
}

module "romedawg_com_hosted_zone" {
  source            = "./romedawg.com"
  ttl               = local.ttl
  delegation_set_id = aws_route53_delegation_set.romedawg_com.id
}

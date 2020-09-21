resource "aws_route53_zone" "romedawg_com" {
  name              = "romedawg.com"
  delegation_set_id = var.delegation_set_id
}

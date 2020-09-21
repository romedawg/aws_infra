resource "aws_route53_delegation_set" "astronomer_romedawg_com" {
  reference_name = "astronomerromedawgNS"
}

resource "aws_route53_zone" "astronomer_romedawg_com" {
  name              = "astronomer.romedawg.com"
  delegation_set_id = aws_route53_delegation_set.astronomer_romedawg_com.id
}

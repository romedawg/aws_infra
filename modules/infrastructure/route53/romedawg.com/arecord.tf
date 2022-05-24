#resource "aws_route53_record" "romedawg_com_a_record" {
#  name    = "romedawg.com"
#  ttl     = var.ttl
#  type    = "A"
#  zone_id = aws_route53_zone.romedawg_com.zone_id
#
#  records = [
#    var.public_alb_dns_name,
#  ]
#}
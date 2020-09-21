resource "aws_route53_record" "romedawg_com_CNAME" {
  name    = "www.romedawg.com"
  ttl     = var.ttl
  type    = "CNAME"
  zone_id = aws_route53_zone.romedawg_com.zone_id

  records = [
    "romedawg.com",
  ]
}

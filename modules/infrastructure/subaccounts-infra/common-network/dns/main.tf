resource "aws_route53_resolver_rule_association" "vpc_resolver_rule_association" {
  resolver_rule_id = var.resolver_rule_id
  vpc_id           = var.vpc_id
}

# resource "aws_route53_zone" "nexus_dev" {
#   name = "nexus.dev.norvax.net"
#
#   vpc {
#     vpc_id = var.vpc_id
#   }
# }

# resource "aws_route53_record" "nexus_dev" {
#   zone_id = aws_route53_zone.nexus_dev.zone_id
#   name    = "nexus.dev.norvax.net"
#   type    = "A"
#   ttl     = 10
#   records = [local.nexus_ip]
# }

# resource "aws_route53_zone" "nexus_ops" {
#   name = "nexus.ops.gohealth.net"
#
#   vpc {
#     vpc_id = var.vpc_id
#   }
# }

# resource "aws_route53_record" "nexus_ops" {
#   zone_id = aws_route53_zone.nexus_ops.zone_id
#   name    = "nexus.ops.gohealth.net"
#   type    = "A"
#   ttl     = 10
#   records = [local.nexus_ip]
# }

# resource "aws_route53_zone" "bb_ops" {
#   name = "bb.ops.gohealth.net"
#
#   vpc {
#     vpc_id = var.vpc_id
#   }
# }

# resource "aws_route53_record" "bb_ops" {
#   zone_id = aws_route53_zone.bb_ops.zone_id
#   name    = "bb.ops.gohealth.net"
#   type    = "A"
#   ttl     = 10
#   records = [local.bitbucket_ip]
# }

# resource "aws_route53_zone" "bb_dev" {
#   name = "bb.dev.norvax.net"
#
#   vpc {
#     vpc_id = var.vpc_id
#   }
# }

# resource "aws_route53_record" "bb_dev" {
#   zone_id = aws_route53_zone.bb_dev.zone_id
#   name    = "bb.dev.norvax.net"
#   type    = "A"
#   ttl     = 10
#   records = [local.bitbucket_ip]
# }

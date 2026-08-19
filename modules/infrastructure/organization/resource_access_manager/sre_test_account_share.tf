# resource "aws_ram_resource_share" "sre-test-share" {
#   name                      = "sre-test-share"
#   allow_external_principals = false
# }
#
# resource "aws_ram_principal_association" "sre-test-tgw-principal-association" {
#   resource_share_arn = aws_ram_resource_share.sre-test-share.arn
#   principal          = local.sre_test_aws_account_id
# }
#
# resource "aws_ram_resource_association" "sre-test-tgw-resource-resource-association" {
#   resource_share_arn = aws_ram_resource_share.sre-test-share.arn
#   resource_arn       = var.transit_gateway_arn
# }
#
# resource "aws_ram_resource_association" "sre-test-norvax-all-resolver-resource-association" {
#   resource_share_arn = aws_ram_resource_share.sre-test-share.arn
#   resource_arn       = data.aws_route53_resolver_rule.norvax_all.arn
# }
#
# resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "sre-test-vpc-dev-attachment" {
#   transit_gateway_attachment_id = "tgw-attach-0b0753a1f067809ac"
# }
#
# resource "aws_ram_resource_association" "sre-test-corp-and-ops-prefix-list-resource-association" {
#   resource_share_arn = aws_ram_resource_share.sre-test-share.arn
#   resource_arn       = var.managed_prefix_arns["corp_and_ops"]
# }

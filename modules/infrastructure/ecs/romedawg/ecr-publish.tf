# data "aws_iam_policy_document" "assume_role_policy_ecr_publisher" {
#   version = "2012-10-17"
#
#   statement {
#     actions = ["sts:AssumeRole"]
#     effect  = "Allow"
#
#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::${var.aws_account_id}:user/rome-testing"]
#
#     }
#   }
# }
#
# data "aws_iam_policy_document" "ecr_publisher" {
#   version = "2012-10-17"
#
#   statement {
#
#     effect = "Allow"
#
#     actions = [
#       "ecr:*"
#     ]
#
#     resources = ["*"]
#   }
#
# }
#
# resource "aws_iam_policy" "ecr_publisher" {
#   name   = "ecr-publisher-${var.environment}"
#   policy = data.aws_iam_policy_document.ecr_publisher.json
#
#   tags = {
#     applications = "jenkins"
#     environment  = var.environment
#   }
# }
#
# resource "aws_iam_role" "ecr_publisher" {
#   name               = "ecr-publisher"
#   assume_role_policy = data.aws_iam_policy_document.assume_role_policy_ecr_publisher.json
#
#   tags = {
#     applications = "ecr"
#     environment  = var.environment
#   }
# }
#
# resource "aws_iam_role_policy_attachment" "ecr_publisher_policy_attachment" {
#   role       = aws_iam_role.ecr_publisher.id
#   policy_arn = aws_iam_policy.ecr_publisher.arn
# }

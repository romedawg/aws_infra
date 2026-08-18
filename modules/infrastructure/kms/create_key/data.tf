data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "root_policy" {
  statement {
    sid    = "Enable IAM policies"
    effect = "Allow"
    principals {
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
      type = "AWS"
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
}

# // Used to grant access to an AWS MGMT Account
# data "aws_iam_policy_document" "root_and_account_policy" {
#   statement {
#     sid    = "Enable IAM policies"
#     effect = "Allow"
#     principals {
#       identifiers = [
#         "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#       ]
#       type = "AWS"
#     }
#     actions   = ["kms:*"]
#     resources = ["*"]
#   }
#   statement {
#     sid    = "Allow use of the key"
#     effect = "Allow"
#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::${var.shared_accounts}:root"]
#     }
#     actions = [
#       "kms:DescribeKey",
#       "kms:GenerateDataKeyWithoutPlainText",
#       "kms:Decrypt",
#       "kms:ReEncrypt*"
#     ]
#     resources = ["*"]
#   }
#   statement {
#     sid    = "Allow attachment of persistent resources"
#     effect = "Allow"
#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::${var.shared_accounts}:root"]
#     }
#     actions   = ["kms:CreateGrant"]
#     resources = ["*"]
#     condition {
#       test     = "Bool"
#       variable = "kms:GrantIsForAWSResource"
#       values   = [true]
#     }
#   }
# }
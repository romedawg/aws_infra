
data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

locals {
  kms_policy_statements = concat(
    [
      {
        Sid    = "Enable IAM policies"
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
            data.aws_iam_session_context.current.issuer_arn,
          ]
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow CMK attachment"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = ["kms:RevokeGrant", "kms:ListGrants", "kms:CreateGrant"]
        Resource = "*"
        Condition = {
          Bool = {
            "kms:GrantIsForAWSResource" = "true"
          }
        }
      },
    ],
    [for id in var.kms_cross_account_principals : {
      Sid    = "Enable IAM User Permissions For ${id} Zscaler data scan"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${id}:root"
      }
      Action = [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:ReEncrypt*",
        "kms:CreateGrant",
        "kms:GenerateDataKeyWithoutPlaintext",
        "kms:PutKeyPolicy",
        "kms:Describe*",
        "kms:Get*",
        "kms:List*",
      ]
      Resource = "*"
    }]
  )
}

resource "aws_kms_key" "ebs" {
  description = "KMS key for EBS encryption in Mysql ${var.environment}"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = local.kms_policy_statements
  })

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_kms_alias" "ebs" {
  name          = "alias/ebs-mysql-${var.environment}"
  target_key_id = aws_kms_key.ebs.key_id
  lifecycle {
    prevent_destroy = true
  }
}

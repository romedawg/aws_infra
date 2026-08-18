resource "aws_kms_key" "default" {
  description = "KMS Key for ${var.service_name}"

  deletion_window_in_days = var.deletion_windows_days

  policy = data.aws_iam_policy_document.root_policy.json

  tags = {
    application = var.service_name
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_kms_alias" "backups_alias" {
  name          = "alias/${var.key_name}"
  target_key_id = aws_kms_key.default.key_id

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_kms_key_policy" "extend_account" {

  count                              = length(var.shared_accounts) == 0 ? 0 : length(var.shared_accounts)
  bypass_policy_lockout_safety_check = false

  key_id = aws_kms_key.default.id

  policy = jsonencode({
    Id = "AllowKMSKeyAccess"
    Statement = [
      {
        Action = [
          "kms:DescribeKey",
          "kms:GenerateDataKeyWithoutPlainText",
          "kms:Decrypt",
          "kms:ReEncrypt*"
        ]
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.shared_accounts[count.index]}:root"
        }

        Resource = "*"
        Sid      = "Allow use of the key"
      },
      {
        Action = ["kms:CreateGrant"]
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.shared_accounts[count.index]}:root"
        }

        Resource = "*"
        Sid      = "Allow attachment of persistent resources"
      }
    ]
    Version = "2012-10-17"
  })
}
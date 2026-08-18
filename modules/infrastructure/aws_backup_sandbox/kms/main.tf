resource "aws_kms_key" "rds_vault" {
  description             = "key used for ${var.key_name} backup vault"
  enable_key_rotation     = true
  deletion_window_in_days = 20
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = var.key_name
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = local.kms_extended_arn
        },
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "a" {
  name          = "alias/${var.key_name}-backup-vault"
  target_key_id = aws_kms_key.rds_vault.key_id
}
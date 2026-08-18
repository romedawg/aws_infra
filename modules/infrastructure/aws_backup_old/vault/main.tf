resource "aws_backup_vault" "service" {
  name        = "${var.vault_service_name}-vault"
  kms_key_arn = var.kms_key_arn
}

// Allow the source account to copy backups to Backup Mgmt Vault
data "aws_iam_policy_document" "vault_copy_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.source_account_id}:root"]
    }

    actions = [
      "backup:CopyIntoBackupVault"
    ]

    resources = [aws_backup_vault.service.arn]
  }
}

resource "aws_backup_vault_policy" "example" {
  backup_vault_name = aws_backup_vault.service.name
  policy            = data.aws_iam_policy_document.vault_copy_policy.json
}

resource "aws_backup_vault_lock_configuration" "default" {
  backup_vault_name = aws_backup_vault.service.name
  # changeable_for_days = var.changeable_for_days
  max_retention_days = var.max_retention_days
  min_retention_days = var.min_retention_days
}
resource "aws_backup_logically_air_gapped_vault" "service" {
  name               = var.vault_name
  encryption_key_arn = var.kms_key_arn
  tags = {
    vault              = var.vault_name
    envrionment        = var.environment
    service            = var.service
    configuration_item = "backup_vault_${var.environment}"
  }
  max_retention_days = var.max_retention_days
  min_retention_days = var.min_retention_days
}

# resource "aws_backup_vault" "service" {
#   name        = var.vault_name
#   kms_key_arn = var.kms_key_arn
#   tags = {
#     vault              = var.vault_name
#     envrionment        = var.environment
#     service            = var.service
#     configuration_item = "backup_vault_${var.environment}"
#   }
# }

// Allow the source account to copy backups to Backup Mgmt Vault
data "aws_iam_policy_document" "single_account" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.source_account_id}:root"]
    }

    actions = [
      "backup:CopyIntoBackupVault"
    ]

    resources = [aws_backup_logically_air_gapped_vault.service.arn]
  }
}

// Organizational policy to allow all accounts to copy to Backup Mgmt Vault
data "aws_iam_policy_document" "organization" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "backup:CopyIntoBackupVault"
    ]

    condition {
      test     = "StringEquals"
      values   = [var.organization_id]
      variable = "aws:PrincipalOrgID"
    }

    resources = [aws_backup_logically_air_gapped_vault.service.arn]
  }
}

// Use single source source policy or organizational policy
resource "aws_backup_vault_policy" "source_account" {
  backup_vault_name = aws_backup_logically_air_gapped_vault.service.name
  policy            = var.source_account_id != "" ? data.aws_iam_policy_document.single_account.json : data.aws_iam_policy_document.organization.json
}

resource "aws_backup_vault_lock_configuration" "default" {
  count             = var.create_vault_lock == false ? 0 : 1
  backup_vault_name = aws_backup_logically_air_gapped_vault.service.name
  // Governance mode by default, changeable_for_days enables compliance mode.
  // When compliance mode is locked, it is immutable, meaning the lock cannot be removed until recovery points are gone
  changeable_for_days = var.changeable_for_days
  max_retention_days  = var.max_retention_days
  min_retention_days  = var.min_retention_days
}

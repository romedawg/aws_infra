// https://gheng.atlassian.net/browse/CLOUD-2318
// Delegated admin policy in Organization Settings
// 644194874299 - Backup MGMT account
// https://repost.aws/knowledge-center/backup-organization-backups
resource "aws_organizations_resource_policy" "delegated_admin_policy" {
  content = data.aws_iam_policy_document.delegated_admin_iam_list_document.json
}

data "aws_iam_policy_document" "delegated_admin_iam_list_document" {
  statement {
    sid    = "AllowOrganizationsRead"
    effect = "Allow"
    principals {
      identifiers = local.backup_mgmt_account_principal
      type        = "AWS"
    }
    actions = [
      "organizations:Describe*",
      "organizations:List*"
    ]

    resources = ["*"]

  }

  statement {
    sid    = "AllowBackupPoliciesCreation"
    effect = "Allow"
    principals {
      identifiers = local.backup_mgmt_account_principal
      type        = "AWS"
    }
    actions = [
      "organizations:CreatePolicy"
    ]
    resources = ["*"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "organizations:PolicyType"
      values   = ["BACKUP_POLICY"]
    }
  }

  statement {
    sid    = "AllowBackupPoliciesModification"
    effect = "Allow"
    principals {
      identifiers = local.backup_mgmt_account_principal
      type        = "AWS"
    }
    actions = [
      "organizations:DescribePolicy",
      "organizations:UpdatePolicy",
      "organizations:DeletePolicy",
    ]
    resources = ["arn:aws:organizations::701164309191:policy/*/backup_policy/*"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "organizations:PolicyType"
      values   = ["BACKUP_POLICY"]
    }
  }

  statement {
    sid    = "AllowBackupPoliciesAttachmentAndDetachmentToAllAccountsAndOUs"
    effect = "Allow"
    principals {
      identifiers = local.backup_mgmt_account_principal
      type        = "AWS"
    }
    actions = [
      "organizations:AttachPolicy",
      "organizations:DetachPolicy"
    ]
    resources = [
      "arn:aws:organizations::701164309191:root/*",
      "arn:aws:organizations::701164309191:ou/*",
      "arn:aws:organizations::701164309191:account/*",
      "arn:aws:organizations::701164309191:policy/*/backup_policy/*"
    ]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "organizations:PolicyType"
      values   = ["BACKUP_POLICY"]
    }
  }
}
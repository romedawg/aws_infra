# resource "aws_organizations_resource_policy" "delegated_admin_policy" {
#   content = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "AllowOrganizationsRead",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::983883744684:root"
#       },
#       "Action": [
#         "organizations:Describe*",
#         "organizations:List*"
#       ],
#       "Resource": "*"
#     },
#     {
#       "Sid": "AllowBackupPoliciesCreation",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::983883744684:root"
#       },
#       "Action": "organizations:CreatePolicy",
#       "Resource": "*",
#       "Condition": {
#         "StringEquals": {
#           "organizations:PolicyType": "BACKUP_POLICY"
#         }
#       }
#     },
#     {
#       "Sid": "AllowBackupPoliciesModification",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::983883744684:root"
#       },
#       "Action": [
#         "organizations:DescribePolicy",
#         "organizations:UpdatePolicy",
#         "organizations:DeletePolicy"
#       ],
#       "Resource": "arn:aws:organizations::701164309191:policy/*/backup_policy/*",
#       "Condition": {
#         "StringEquals": {
#           "organizations:PolicyType": "BACKUP_POLICY"
#         }
#       }
#     },
#     {
#       "Sid": "AllowBackupPoliciesAttachmentAndDetachmentToAllAccountsAndOUs",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::983883744684:root"
#       },
#       "Action": [
#         "organizations:AttachPolicy",
#         "organizations:DetachPolicy"
#       ],
#       "Resource": [
#         "arn:aws:organizations::701164309191:root/*",
#         "arn:aws:organizations::701164309191:ou/*",
#         "arn:aws:organizations::701164309191:account/*",
#         "arn:aws:organizations::701164309191:policy/*/backup_policy/*"
#       ],
#       "Condition": {
#         "StringEquals": {
#           "organizations:PolicyType": "BACKUP_POLICY"
#         }
#       }
#     }
#   ]
# }
# EOF
# }

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
      "organizations:DeletePolicy"
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
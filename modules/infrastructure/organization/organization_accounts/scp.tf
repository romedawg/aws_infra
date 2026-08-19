# data "aws_iam_policy_document" "base_deny_list_document" {
#
#   # Deny leaving AWS organization
#   statement {
#     sid    = "LeaveOrganization"
#     effect = "Deny"
#     actions = [
#       "organizations:LeaveOrganization"
#     ]
#     resources = ["*"]
#
#     condition {
#       test     = "ArnNotLike"
#       variable = "aws:PrincipalARN"
#       values   = local.managed_accounts_superprincipals
#     }
#   }
#
#   # Deny modifications of superprincipals so that nobody tampers with their trust policies
#   statement {
#     sid    = "UpdateSuperPrincipals"
#     effect = "Deny"
#     actions = [
#       "iam:Attach*",
#       "iam:Detach*",
#       "iam:Put*",
#       "iam:Update*",
#       "iam:Delete*",
#       "iam:CreateAccessKey",
#     ]
#     resources = local.managed_accounts_superprincipals
#
#     condition {
#       test     = "ArnNotLike"
#       variable = "aws:PrincipalARN"
#       values   = local.managed_accounts_superprincipals
#     }
#   }
#
#   # Deny assumption of role that has read/write access to terraform state of base infrastructure
#   statement {
#     sid    = "AssumeTerraformStateRole"
#     effect = "Deny"
#     actions = [
#       "sts:AssumeRole",
#     ]
#     resources = ["arn:aws:iam::701164309191:role/tf-sub-statemgmt-*-base"]
#
#     condition {
#       test     = "ArnNotLike"
#       variable = "aws:PrincipalARN"
#       values   = local.managed_accounts_superprincipals
#     }
#   }
#
#   # Deny access to saving plans
#   statement {
#     sid    = "SavingsPlans"
#     effect = "Deny"
#     actions = [
#       "savingsplans:*",
#       "purchase-orders:*",
#     ]
#     resources = ["*"]
#
#     condition {
#       test     = "ArnNotLike"
#       variable = "aws:PrincipalARN"
#       values   = local.managed_accounts_superprincipals
#     }
#   }
#
#   # Deny write access to Marketplace
#   statement {
#     sid    = "AwsMarketplace"
#     effect = "Deny"
#     actions = [
#       "aws-marketplace:Accept*",
#       "aws-marketplace:AssociateProducts*",
#       "aws-marketplace:DisassociateProducts*",
#       "aws-marketplace:Cancel*",
#       "aws-marketplace:Create*",
#       "aws-marketplace:Reject*",
#       "aws-marketplace:Subscribe",
#       "aws-marketplace:Unsubscribe",
#       "aws-marketplace:Update*",
#     ]
#     resources = ["*"]
#
#     condition {
#       test     = "ArnNotLike"
#       variable = "aws:PrincipalARN"
#       values   = ["arn:aws:iam::*:role/AWSControlTowerExecution"]
#     }
#   }
#
# }
#
# data "aws_iam_policy_document" "managed_accounts_deny_list_document" {
#   # Deny modification of network infrastructure
#   statement {
#     sid    = "NetworkInfrastructure"
#     effect = "Deny"
#     actions = [
#       "ec2:CreateSubnet",
#       "ec2:DeleteSubnet",
#       "ec2:DisassociateSubnetCidrBlock",
#       "ec2:AssociateSubnetCidrBlock",
#       "ec2:ModifySubnetAttribute",
#       "ec2:ModifyTransitGateway*",
#       "ec2:CreateTransitGateway*",
#       "ec2:DeleteTransitGateway*",
#       "ec2:ReplaceTransitGatewayRoute",
#       "ec2:AssociateTransitGatewayRouteTable",
#       "ec2:DeleteNatGateway",
#       "ec2:ReplaceNetworkAclEntry",
#       "ec2:CreateInternetGateway",
#       "ec2:DeleteInternetGateway",
#       "ec2:DeleteEgressOnlyInternetGateway",
#       "ec2:DetachInternetGateway",
#       "ec2:ReplaceRoute*",
#       "ec2:AssociateRouteTable",
#       "ec2:CreateRoute*",
#       "ec2:DeleteRoute*",
#       "ec2:DisassociateRouteTable*",
#       "ec2:CreateVpc",
#       "ec2:DeleteVpc",
#       "ec2:DisassociateVpcCidrBlock",
#       "ec2:ModifyVpcAttribute",
#     ]
#
#     resources = ["*"]
#
#     condition {
#       test     = "ArnNotLike"
#       variable = "aws:PrincipalARN"
#       values   = local.managed_accounts_superprincipals
#     }
#
#   }
#
#   # Deny tampering with tags that are used by this SCP
#   statement {
#     sid    = "Tags"
#     effect = "Deny"
#     actions = [
#       "ec2:CreateTags",
#       "ec2:DeleteTags",
#     ]
#     resources = ["*"]
#
#     condition {
#       test     = "StringEquals"
#       variable = "aws:ResourceTag/public"
#       values   = ["true"]
#     }
#
#     condition {
#       test     = "ArnNotLike"
#       variable = "aws:PrincipalARN"
#       values   = local.managed_accounts_superprincipals
#     }
#
#   }
#
#   # Deny creating of new resources in public subnets
#   statement {
#     sid    = "ResourcesInPublicSubnets"
#     effect = "Deny"
#     actions = [
#       "ec2:CreateNetworkInterface"
#     ]
#     resources = ["*"]
#
#     condition {
#       test     = "StringEquals"
#       variable = "aws:ResourceTag/public"
#       values   = ["true"]
#     }
#
#     condition {
#       test     = "ArnNotLike"
#       variable = "aws:PrincipalARN"
#       values   = local.managed_accounts_superprincipals
#     }
#   }
# }
#
# data "aws_iam_policy_document" "suspended_deny_list" {
#   statement {
#     sid    = "DenyEverything"
#     effect = "Deny"
#     actions = [
#       "*",
#     ]
#     resources = ["*"]
#
#     condition {
#       test     = "ArnNotLike"
#       variable = "aws:PrincipalARN"
#       values   = local.managed_accounts_superprincipals
#     }
#   }
# }
#
# resource "aws_organizations_policy" "base_deny_list" {
#   name    = "BaseDenyList"
#   content = data.aws_iam_policy_document.base_deny_list_document.json
#
#   lifecycle {
#     ignore_changes = [content]
#   }
# }
#
# resource "aws_organizations_policy" "managed_accounts_deny_list" {
#   name    = "ManagedAccountsDenyList"
#   content = data.aws_iam_policy_document.managed_accounts_deny_list_document.json
# }
#
# # Base deny list is expected to be applied to all accounts except for management account
# resource "aws_organizations_policy_attachment" "base_deny_list_attachments" {
#   for_each = toset([
#     aws_organizations_organizational_unit.qa.id,
#     aws_organizations_organizational_unit.uat.id,
#     aws_organizations_organizational_unit.prod.id,
#     aws_organizations_organizational_unit.business_continuity.id,
#     aws_organizations_organizational_unit.individual_business_users.id,
#     aws_organizations_organizational_unit.infrastructure.id,
#     aws_organizations_organizational_unit.sandbox.id,
#     aws_organizations_organizational_unit.security.id,
#     aws_organizations_organizational_unit.suspended.id,
#   ])
#   policy_id = aws_organizations_policy.base_deny_list.id
#   target_id = each.key
# }
#
# # Deny Modification of network(EC2:*network related* policies)
# resource "aws_organizations_policy_attachment" "managed_accounts_deny_list_attachments" {
#   for_each = toset([
#     aws_organizations_organizational_unit.qa.id,
#     aws_organizations_organizational_unit.uat.id,
#     aws_organizations_organizational_unit.prod.id,
#     aws_organizations_organizational_unit.business_continuity.id,
#     aws_organizations_organizational_unit.individual_business_users.id,
#     aws_organizations_organizational_unit.infrastructure.id,
#     aws_organizations_organizational_unit.sandbox.id,
#     aws_organizations_organizational_unit.security.id,
#     // Omitting:
#     //  aws_organizations_organizational_unit.suspended.id -> that already denies everything
#   ])
#   policy_id = aws_organizations_policy.managed_accounts_deny_list.id
#   target_id = each.key
# }
#
# # Deny IAM Create/Delete/Attach permissions
# data "aws_iam_policy_document" "managed_accounts_deny_iam_list_document" {
#   statement {
#     sid    = "DenyIAMItems"
#     effect = "Deny"
#     actions = [
#       "iam:CreateUser",
#       "iam:CreateOpenIDConnect*",
#     ]
#
#     resources = ["*"]
#
#     condition {
#       test     = "ArnNotLike"
#       variable = "aws:PrincipalARN"
#       values   = local.managed_accounts_superprincipals
#     }
#
#   }
# }
#
# resource "aws_organizations_policy" "managed_accounts_iam_deny_list" {
#   name    = "ManagedAccountsIAMDenyList"
#   content = data.aws_iam_policy_document.managed_accounts_deny_iam_list_document.json
# }
#
# resource "aws_organizations_policy_attachment" "iam_deny_iam_user_mod_attachments" {
#   for_each = toset([
#     module.data_science.account_info["Data Science"].account_id,
#     module.it_infra.account_info["IT Infra"].account_id
#   ])
#   policy_id = aws_organizations_policy.managed_accounts_iam_deny_list.id
#   target_id = each.key
# }
#
#
# resource "aws_organizations_policy" "suspended_deny_everything_list" {
#   name    = "SuspendedDenyEverythingList"
#   content = data.aws_iam_policy_document.suspended_deny_list.json
# }
#
# resource "aws_organizations_policy_attachment" "suspended_deny_everything_list_attachments" {
#   for_each = toset([
#     aws_organizations_organizational_unit.suspended.id,
#   ])
#   policy_id = aws_organizations_policy.suspended_deny_everything_list.id
#   target_id = each.key
# }

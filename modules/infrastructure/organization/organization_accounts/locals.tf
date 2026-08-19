locals {
  # list of users and roles that are not affected by SCP rules i.e. have real admin access. Wildcards are allowed.
  managed_accounts_superprincipals = [
    "arn:aws:iam::*:user/terraform-admin",
    # "arn:aws:iam::*:role/OrganizationAccountAccessRole",
    # "arn:aws:iam::590183668934:user/terraform-waf",
    # "arn:aws:iam::*:role/spacelift/*-aws_network",
  ]
  backup_mgmt_account_principal = [
    "arn:aws:iam::983883744684:root"
  ]
}
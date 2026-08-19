locals {
  root_account_id = "453357546588"
}

data "aws_iam_policy_document" "allow_assume_role_route53_manager" {
  statement {
    actions   = ["sts:AssumeRole"]
    effect    = "Allow"
    resources = ["arn:aws:iam::${local.root_account_id}:role/route53-manager-*"]
  }
}

resource "aws_iam_policy" "allow_assume_role_route53-manager-all" {
  name        = "AllowAssumeRoleInAccountA"
  description = "Allows the user to assume the Route53 management role in Root account"

  policy = data.aws_iam_policy_document.allow_assume_role_route53_manager.json
}

resource "aws_iam_user_policy_attachment" "attach_terraform_admin" {
  user       = "terraform-admin"
  policy_arn = aws_iam_policy.allow_assume_role_route53-manager-all.arn
}
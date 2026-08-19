resource "aws_iam_user" "terraform_waf" {
  name = "terraform-waf"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::*:role/terraform-waf",
      "arn:aws:iam::453357546588:role/tf-sub-statemgmt-*-vendor"
    ]
  }
}

resource "aws_iam_user_policy" "assume_role_policy" {
  name   = "terraform-waf-assume-role"
  policy = data.aws_iam_policy_document.assume_role_policy.json
  user   = aws_iam_user.terraform_waf.name
}
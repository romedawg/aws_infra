data "aws_iam_policy_document" "assume_role_policy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["590183668934"]
    }
  }
}

data "aws_iam_policy_document" "terraform_state_policy" {
  version = "2012-10-17"
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::terraform-terraformstatebucket-10qyexw39oruj",
      "arn:aws:s3:::terraform-terraformstatebucket-10qyexw39oruj/*"
    ]

    condition {
      test     = "StringNotLike"
      values   = ["aws-subaccounts/*"]
      variable = "s3:prefix"
    }
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [
      "arn:aws:dynamodb:*:*:table/terraform-TerraformLockTable-1WPNYS4HW3R3S"
    ]

    condition {
      test     = "ForAllValues:StringNotLike"
      variable = "dynamodb:LeadingKeys"
      values   = ["terraform-terraformstatebucket-10qyexw39oruj/aws-subaccounts/*"]
    }
  }
}

resource "aws_iam_role" "terraform_state_access" {
  name               = "tf-sub-statemgmt-453357546588-vendor"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  inline_policy {
    name   = "TerraformStateAccess"
    policy = data.aws_iam_policy_document.terraform_state_policy.json
  }
}
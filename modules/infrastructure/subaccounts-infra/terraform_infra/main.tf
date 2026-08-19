resource "aws_iam_user" "terraform_user" {
  name = "terraform-admin"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user" "terraform_vendor_user" {
  name = "terraform-vendor"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user_policy" "terraform_user_policy" {
  name = "terraform-user-policy"
  user = aws_iam_user.terraform_user.name

  policy = data.aws_iam_policy_document.terraform_policy_document.json

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user_policy" "terraform_vendor_user_policy" {
  name = "terraform-vendor-user-policy"
  user = aws_iam_user.terraform_vendor_user.name

  # permissions of terraform-vendor user are restricted by SCP
  policy = data.aws_iam_policy_document.terraform_policy_document.json

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_access_key" "terraform_key" {
  user = aws_iam_user.terraform_user.name

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_access_key" "terraform_vendor_key" {
  user = aws_iam_user.terraform_vendor_user.name

  lifecycle {
    prevent_destroy = true
  }
}

data "aws_iam_policy_document" "terraform_policy_document" {
  statement {
    actions = [
      "*"
    ]

    resources = ["*"]
  }
}

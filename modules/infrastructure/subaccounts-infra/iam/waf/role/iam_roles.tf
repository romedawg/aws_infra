data "aws_iam_policy_document" "assume_role_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      identifiers = ["arn:aws:iam::590183668934:user/terraform-waf"]
      type        = "AWS"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "waf_management" {
  name               = "terraform-waf"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "waf_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AWSWAFFullAccess"
  role       = aws_iam_role.waf_management.name
}
data "aws_iam_policy_document" "trust_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.root_account_id}:root"]
    }

    actions = ["sts:AssumeRole"]
  }
}

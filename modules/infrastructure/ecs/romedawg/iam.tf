data "aws_iam_policy_document" "romedawg_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameter", "ssm:GetParameters", "ssm:GetParametersByPath"]
    resources = ["arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter/${var.environment}/romedawg/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets"
    ]
    resources = ["arn:aws:s3:::*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::romedawg-${var.environment}*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetObject",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:PutObject"
    ]
    resources = ["arn:aws:s3:::romedawg-${var.environment}*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:TagResource"
    ]
    resources = ["*"]
  }


}

resource "aws_iam_policy" "romedawg_policy" {
  name   = "${var.environment}-romedawg-policy"
  policy = data.aws_iam_policy_document.romedawg_policy_document.json
}

resource "aws_iam_role_policy_attachment" "romedawg_policy_attachment" {
  policy_arn = aws_iam_policy.romedawg_policy.arn
  role       = module.base.service["task_role_name"]
}

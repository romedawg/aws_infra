data "aws_iam_policy_document" "elastic_container_service_iam_policy" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "acm-pca:GetCertificate",
      "acm-pca:GetCertificateAuthorityCertificate",
      "acm-pca:ListCertificateAuthorities",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["ec2:DescribeInstances"]
  }

  statement {
    sid    = ""
    effect = "Allow"

    resources = [
      "arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter/all/*",
    ]

    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:secretsmanager:us-east-2:453357546588:secret:nexus-aws-*"]
    actions   = ["secretsmanager:GetSecretValue"]
  }

  # statement {
  #   sid       = ""
  #   effect    = "Allow"
  #   resources = ["${var.heapdumps_s3_bucket_arn}/heapdumps/*"]
  #   actions   = ["s3:PutObject"]
  # }
}

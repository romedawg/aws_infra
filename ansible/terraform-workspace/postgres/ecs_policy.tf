resource "aws_iam_policy" "elastic_container_service" {
  name        = "${local.environment}-elastic-container-service"
  description = "Policy that can be attached to all services running within AWS Elastic Container Service for the set of permissions that any service would need"
  policy      = data.aws_iam_policy_document.elastic_container_service_iam_policy.json
}

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
      "arn:aws:ssm:${local.aws_region}:${local.aws_account_id}:parameter/all/new_relic/account_id",
      "arn:aws:ssm:${local.aws_region}:${local.aws_account_id}:parameter/all/new_relic/insights_api_insert_key",
      "arn:aws:ssm:${local.aws_region}:${local.aws_account_id}:parameter/all/new_relic/license_key",
      "arn:aws:ssm:${local.aws_region}:${local.aws_account_id}:parameter/all/new_relic/license_key_fake",
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

}
data "aws_iam_policy_document" "allow_assume_role" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "postgres_role_policy" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "ec2:Describe*",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter/postgres/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:Put*",
      "s3:ListMultipartUploadParts",
    ]

    resources = ["arn:aws:s3:::sre-ops-20190409202038830900000001/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = ["arn:aws:s3:::sre-ops-20190409202038830900000001"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = ["arn:aws:s3:::ops-gohealth-bucket/sre/ec2-userdata-tools/*"]
  }
}

resource "aws_iam_role" "postgres" {
  name = "-postgres-cluster-${var.cluster}"

  assume_role_policy = data.aws_iam_policy_document.allow_assume_role.json
}

resource "aws_iam_instance_profile" "postgres" {
  name       = "postgres-cluster"
  role       = aws_iam_role.postgres.name
  depends_on = [aws_iam_role_policy.postgres]
}

resource "aws_iam_role_policy" "postgres" {
  name   = "postgres-cluster"
  role   = aws_iam_role.postgres.id
  policy = data.aws_iam_policy_document.postgres_role_policy.json
}

resource "aws_iam_role_policy_attachment" "consul_ssm" {
  count      = var.ssm_agent_policy_arn == "" ? 0 : 1
  policy_arn = var.ssm_agent_policy_arn
  role       = aws_iam_role.postgres.id
}

data "aws_iam_policy_document" "ecs_taskrole_policy" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_taskrole" {
  name               = "${local.application_name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_taskrole_policy.json

  tags = {
    application = local.application_name
  }
}

resource "aws_iam_role_policy_attachment" "ecs_taskrole_attachment_one" {
  role       = aws_iam_role.ecs_taskrole.name
  policy_arn = var.ecs_managed_policy_arn
}

data "aws_iam_policy_document" "postgres" {
  version = "2012-10-17"

  statement {
    sid = "Logs"

    actions = [
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:CreateLogStream",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:log-group:/aws/postgres:log-stream:*",
    ]
  }

  statement {
    sid = "LogsGroups"

    actions = [
      "logs:CreateLogGroup",
    ]

    effect = "Allow"

    resources = ["*"]
  }
}

resource "aws_iam_policy" "postgres" {
  name   = "postgres"
  policy = data.aws_iam_policy_document.postgres.json
}

resource "aws_iam_role_policy_attachment" "postgres_attachment" {
  role       = aws_iam_role.ecs_taskrole.name
  policy_arn = aws_iam_policy.postgres.arn
}


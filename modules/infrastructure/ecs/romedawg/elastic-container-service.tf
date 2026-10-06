resource "aws_iam_policy" "elastic_container_service" {
  name        = "${var.environment}-elastic-container-service-rome"
  description = "Policy that can be attached to all services running within AWS Elastic Container Service for the set of permissions that any service would need"
  policy      = data.aws_iam_policy_document.elastic_container_service_iam_policy.json
}

data "aws_iam_policy_document" "trust_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "codedeploy.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "container_instance_policy" {
  version = "2012-10-17"

  statement {
    actions = [
      "ec2:DescribeTags",
      "ec2:DescribeInstances",
      "ecs:DescribeServices",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:UpdateContainerInstancesState",
      "ecs:Submit*",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::ops-gohealth-bucket/sre/ec2-userdata-tools/*",
    ]
  }

  statement {
    actions = [
      "ssm:GetParametersByPath",
      "ssm:GetParameters",
      "ssm:GetParameter",
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter/all/new_relic/*",
      "arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter/all/ad/adawsread/*",
    ]
  }
}

resource "aws_iam_role" "container_instance" {
  name               = "${var.environment}-container_instance-rome"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}

resource "aws_iam_instance_profile" "container_instance" {
  name = "${var.environment}-container_instance-rome"
  role = aws_iam_role.container_instance.name

  depends_on = [aws_iam_role_policy.container_instance]
}

resource "aws_iam_role_policy" "container_instance" {
  name   = "${var.environment}-container_instance-rome"
  role   = aws_iam_role.container_instance.id
  policy = data.aws_iam_policy_document.container_instance_policy.json
}


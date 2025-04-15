data "aws_iam_policy_document" "trust_policy" {
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

// necessary for deploying fluentD as a daemonset that streams logs from EKS into cloudwatch
// See here: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-setup-logs.html
data "aws_iam_policy_document" "cloudwatch_logs" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "logs:Describe*",
      "logs:List*",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:TestMetricFilter",
      "logs:FilterLogEvents",
      "logs:Get*",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:log-group:/aws/containerinsights*",
      "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:log-group:/aws/containerinsights*:*:*",
    ]
  }
}

resource "aws_iam_policy" "cloudwatch_logs" {
  name   = "${var.environment}-EKS-ManagedNodes-Cloudwatch-Logs"
  policy = data.aws_iam_policy_document.cloudwatch_logs.json
}

data "aws_iam_policy_document" "airflow_s3_logs" {
  version = "2012-10-17"

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
      "s3:PutObject",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::sre-ops-20190409202038830900000001/*",
    ]
  }
}

resource "aws_iam_policy" "airflow_s3_logs" {
  name   = "${var.environment}-airflow-s3-logs"
  policy = data.aws_iam_policy_document.airflow_s3_logs.json
}

data "aws_iam_policy_document" "assume_airflow_s3_logs" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      aws_iam_role.airflow_s3_logs.arn
    ]
  }

}

resource "aws_iam_policy" "assume_airflow_s3_logs" {
  name   = "${var.environment}-assume-airflow-s3-logs"
  policy = data.aws_iam_policy_document.assume_airflow_s3_logs.json
}

data "aws_iam_policy_document" "airflow_s3_logs_policy" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.managed_node.arn]
    }
  }
}

resource "aws_iam_role" "airflow_s3_logs" {
  name               = "${var.environment}-airflow-s3-logs"
  assume_role_policy = data.aws_iam_policy_document.airflow_s3_logs_policy.json

  tags = {
    application = "airflow"
    enviroment  = var.environment
  }
}

resource "aws_iam_role" "managed_node" {
  name               = "EKSManagedNodeRole-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json

  tags = {
    applications = "eks-managed-node"
    enviroment   = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "airflow_s3_logs_policy" {
  policy_arn = aws_iam_policy.airflow_s3_logs.arn
  role       = aws_iam_role.airflow_s3_logs.name
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  policy_arn = aws_iam_policy.cloudwatch_logs.arn
  role       = aws_iam_role.managed_node.name
}

resource "aws_iam_role_policy_attachment" "node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.managed_node.name
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.managed_node.name
}

resource "aws_iam_role_policy_attachment" "container_registry_read_only_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.managed_node.name
}

resource "aws_iam_role_policy_attachment" "assume_airflow_s3_logs_policy" {
  policy_arn = aws_iam_policy.assume_airflow_s3_logs.arn
  role       = aws_iam_role.managed_node.name
}

resource "aws_iam_role_policy_attachment" "ssm_agent" {
  count      = var.ssm_agent_policy_arn == "" ? 0 : 1
  policy_arn = var.ssm_agent_policy_arn
  role       = aws_iam_role.managed_node.name
}

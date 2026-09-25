# IRSA role for Airflow scheduler - needs S3 access for logs/DAGs
data "aws_iam_policy_document" "airflow_scheduler_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_url}:sub"
      values   = ["system:serviceaccount:${var.astronomer_namespace}:airflow-scheduler"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_url}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "airflow_scheduler" {
  name               = "${local.name_prefix}-airflow-scheduler"
  assume_role_policy = data.aws_iam_policy_document.airflow_scheduler_assume.json
  tags               = local.common_tags
}

data "aws_iam_policy_document" "airflow_scheduler" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.astronomer_logs.arn,
      "${aws_s3_bucket.astronomer_logs.arn}/*",
      aws_s3_bucket.astronomer_dags.arn,
      "${aws_s3_bucket.astronomer_dags.arn}/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
    ]
    resources = [
      aws_secretsmanager_secret.db_credentials.arn,
      aws_secretsmanager_secret.astronomer_platform.arn,
    ]
  }
}

resource "aws_iam_policy" "airflow_scheduler" {
  name        = "${local.name_prefix}-airflow-scheduler"
  description = "Permissions for Airflow scheduler IRSA role"
  policy      = data.aws_iam_policy_document.airflow_scheduler.json
  tags        = local.common_tags
}

resource "aws_iam_role_policy_attachment" "airflow_scheduler" {
  role       = aws_iam_role.airflow_scheduler.name
  policy_arn = aws_iam_policy.airflow_scheduler.arn
}

# IRSA role for Airflow workers - S3 log access
data "aws_iam_policy_document" "airflow_worker_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_url}:sub"
      values   = ["system:serviceaccount:${var.astronomer_namespace}:airflow-worker"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_url}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "airflow_worker" {
  name               = "${local.name_prefix}-airflow-worker"
  assume_role_policy = data.aws_iam_policy_document.airflow_worker_assume.json
  tags               = local.common_tags
}

data "aws_iam_policy_document" "airflow_worker" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.astronomer_logs.arn,
      "${aws_s3_bucket.astronomer_logs.arn}/*",
      aws_s3_bucket.astronomer_dags.arn,
      "${aws_s3_bucket.astronomer_dags.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "airflow_worker" {
  name        = "${local.name_prefix}-airflow-worker"
  description = "Permissions for Airflow worker IRSA role"
  policy      = data.aws_iam_policy_document.airflow_worker.json
  tags        = local.common_tags
}

resource "aws_iam_role_policy_attachment" "airflow_worker" {
  role       = aws_iam_role.airflow_worker.name
  policy_arn = aws_iam_policy.airflow_worker.arn
}

# IRSA role for Astronomer Houston API (platform control plane)
data "aws_iam_policy_document" "houston_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_url}:sub"
      values   = ["system:serviceaccount:${var.astronomer_namespace}:astronomer-houston"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_url}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "houston" {
  name               = "${local.name_prefix}-houston"
  assume_role_policy = data.aws_iam_policy_document.houston_assume.json
  tags               = local.common_tags
}

data "aws_iam_policy_document" "houston" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecrets",
    ]
    resources = [
      "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:${local.name_prefix}/*",
    ]
  }
}

resource "aws_iam_policy" "houston" {
  name        = "${local.name_prefix}-houston"
  description = "Permissions for Astronomer Houston API IRSA role"
  policy      = data.aws_iam_policy_document.houston.json
  tags        = local.common_tags
}

resource "aws_iam_role_policy_attachment" "houston" {
  role       = aws_iam_role.houston.name
  policy_arn = aws_iam_policy.houston.arn
}
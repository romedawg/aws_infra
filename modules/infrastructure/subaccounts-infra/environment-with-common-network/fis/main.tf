locals {
  root_account_id = "453357546588"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "trust_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::${local.root_account_id}:root"
      ]
    }
  }
}

resource "aws_iam_role" "fis_experiments_starter_role" {
  name               = "fis-experiments-starter"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}

data "aws_iam_policy_document" "fis_experiments_starter_policy_document" {
  statement {
    actions = [
      "fis:StartExperiment",
      "fis:TagResource",
      "fis:GetExperiment",
      "fis:ListExperimentTemplates",
      "fis:ListActions",
      "fis:GetAction",
      "fis:StopExperiment",
      "fis:GetExperimentTemplate",
      "fis:ListTargetResourceTypes",
      "fis:ListExperiments",
      "fis:ListTagsForResource",
      "fis:GetTargetResourceType"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "fis_experiments_starter_policy" {
  name   = "fis-experiments-starter"
  policy = data.aws_iam_policy_document.fis_experiments_starter_policy_document.json
}

resource "aws_iam_role_policy_attachment" "fis_experiments_starter_role_policy_attachment" {
  policy_arn = aws_iam_policy.fis_experiments_starter_policy.arn
  role       = aws_iam_role.fis_experiments_starter_role.name
}

# experiment logs bucket
# module "fis_logs_bucket" {
#   source = "./fis_logs_bucket"
#
#   bucket_prefix  = "fis-logs"
#   bucket_purpose = "Store FIS experiments logs"
# }

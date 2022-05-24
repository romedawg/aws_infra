resource "aws_iam_policy" "ssm_agent_instance_policy" {
  name   = "${local.environment}-allow-ssm-agent-operations"
  policy = data.aws_iam_policy_document.ssm_agent_instance_policy.json
}

# https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-setting-up-messageAPIs.html
data "aws_iam_policy_document" "ssm_agent_instance_policy" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
      "ssm:DescribeAssociation",
      "ssm:DescribeInstanceProperties",
      "ssm:DescribeDocument",
      "ssm:DescribeDocumentParameters",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:GetManifest",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:PutInventory",
      "ssm:PutComplianceItems",
      "ssm:PutConfigurePackageResult",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation",
    ]
  }


  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["iam:PassRole"]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["ssm.amazonaws.com"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["sns:Publish"]
  }
}
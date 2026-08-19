data "aws_iam_policy_document" "assume_role_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      identifiers = ["arn:aws:iam::453357546588:root"]
      type        = "AWS"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "control_tower_management" {
  name                = "AWSControlTowerExecution"
  assume_role_policy  = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

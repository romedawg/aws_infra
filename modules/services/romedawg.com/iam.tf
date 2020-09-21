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

data "aws_iam_policy_document" "romedawg_policy" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "ssm:GetParametersByPath",
      "ssm:GetParameter",
      "ssm:GetParameters",
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter/romedawg/*"
    ]
  }

}

resource "aws_iam_role" "romedawg_role" {
  name = "romedawg"

  assume_role_policy = data.aws_iam_policy_document.allow_assume_role.json
}

resource "aws_iam_instance_profile" "romedawg_profile" {
  name       = "romedawg"
  role       = aws_iam_role.romedawg_role.name
  depends_on = [aws_iam_role_policy.romedawg_policy]
}

resource "aws_iam_role_policy" "romedawg_policy" {
  name   = "romedawg"
  role   = aws_iam_role.romedawg_role.id
  policy = data.aws_iam_policy_document.romedawg_policy.json
}

//resource "aws_iam_role_policy_attachment" "romedawg_ssm_agent" {
//  count      = var.ssm_agent_policy_arn == "" ? 0 : 1
//  policy_arn = var.ssm_agent_policy_arn
//  role       = aws_iam_role.romedawg_role.id
//}

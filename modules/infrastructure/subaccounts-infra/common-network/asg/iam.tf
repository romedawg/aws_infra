data "aws_caller_identity" "current" {}

data "aws_iam_policy" "autoscalingRolePolicy" {
  arn = "arn:aws:iam::aws:policy/aws-service-role/AutoScalingServiceRolePolicy"
}
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        aws_iam_service_linked_role.autoscaling_linked_role.arn,
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_service_linked_role" "autoscaling_linked_role" {
  aws_service_name = "autoscaling.amazonaws.com"
}

resource "aws_iam_role" "role" {
  name               = "${var.environment}-asg-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# # KMS key id from root account
# # arn:aws:kms:us-east-2:453357546588:key/3ca1404b-6364-4d67-92b3-b85d9e7ec135
# resource "aws_kms_grant" "grant" {
#   name              = "${var.environment}-asg-grant"
#   key_id            = "arn:aws:kms:${var.aws_region}:${var.root_account_id}:key/3ca1404b-6364-4d67-92b3-b85d9e7ec135"
#   grantee_principal = aws_iam_role.role.arn
#   operations = [
#     "Encrypt",
#     "Decrypt",
#     "ReEncryptFrom",
#     "ReEncryptTo",
#     "GenerateDataKey",
#     "GenerateDataKeyWithoutPlaintext",
#     "DescribeKey",
#     "CreateGrant"
#   ]
# }

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "jitna_instance_profile_session_recording" {
  statement {
    actions = [
      "s3:GetEncryptionConfiguration",
      "s3:PutObject",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:s3:::aws-ssm-session-logs-${data.aws_caller_identity.current.account_id}",
      "arn:aws:s3:::aws-ssm-session-logs-${data.aws_caller_identity.current.account_id}/*"
    ]
  }
}

resource "aws_iam_policy" "jitna_instance_profile_session_recordings_policy" {
  name   = "jitna-instance-profile-session-recording"
  policy = data.aws_iam_policy_document.jitna_instance_profile_session_recording.json
}

locals {
  kms_extended_arn = "" ? "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" : "arn:aws:iam::${var.source_account_id}:root"
}
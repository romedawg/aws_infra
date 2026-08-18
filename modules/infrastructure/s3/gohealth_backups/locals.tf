locals {
  s3_bucket_name = "rome-testing-${data.aws_caller_identity.current.account_id}"
}
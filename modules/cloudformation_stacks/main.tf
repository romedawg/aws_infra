# If you want to use cloud formation stacks
resource "aws_cloudformation_stack" "aws-testing" {
  name          = "rome-infra-testing"
  template_body = file("${path.module}/s3BucketStack.yml")


}
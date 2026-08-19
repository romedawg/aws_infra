resource "aws_ec2_instance_metadata_defaults" "default_imdsv2" {
  http_tokens = "required"
}

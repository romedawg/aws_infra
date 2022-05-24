variable "environment" {
  description = "environment that the backup node is being deployed to"
}

variable "security_group" {
  description = "id of the security group attached to the host"
}

variable "subnet" {
}

variable "key_name" {
  description = "Description: Name of the SSH public key to be injected into the host's unix user's authorized_keys file"
}

variable "data_volume_size" {
  default     = "20"
  description = "unit is in GB"
}

variable "aws_region" {
}

variable "aws_account_id" {
}

variable "application" {
  description = "application for ECS tasks; ECS containers will be tagged using this value in init. Example value is ::qa-app1::qa-app2::qa-app3:: "
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name"
}

variable "amazonlinux_patch_group" {
  description = "patch group to use in tag so that the ubuntu instances are patched"
  default     = ""
}

variable "instance_type" {
  description = "default instance type, we should be using t3 here"
  default     = "t3.small"
}

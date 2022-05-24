variable "environment" {
  description = "environment that the backup node is being deployed to"
}

variable "key_name" {
  description = "Description: Name of the SSH public key to be injected into the host's unix user's authorized_keys file"
}

variable "security_group" {
  description = "id of the security group attached to the host"
}

variable "subnet" {
}

variable "aws_region" {
}

variable "aws_account_id" {
}

variable "zone_id" {}

//variable "ubuntu_patch_group" {
//  description = "patch group to use in tag so that the ubuntu instances are patched"
//  default     = ""
//}
//
//variable "ssm_agent_policy_arn" {
//  description = "policy to apply to instances running ssm agent"
//  default     = ""
//}

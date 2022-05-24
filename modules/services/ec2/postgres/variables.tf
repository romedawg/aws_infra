variable "availability_zone_2a_metadata" {
  type = object({
    zone_id   = string,
    subnet_id = string,
  })
}

variable "key_name" {
  description = "Description: Name of the SSH public key to be injected into the host's unix user's authorized_keys file"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "data_dir_volume_size" {
  default     = "50"
  description = "Disk Volume in GiB"
}

variable "mysql_tmp_volume_size" {
  default     = "25"
  description = "Disk Volume in GiB"
}

variable "mysql_backup_volume_size" {
  default     = "0"
  description = "Disk Volume in GiB"
}

variable "custom_iops" {
  default = 0
}

variable "security_group" {
  description = "id of the security group attached to the host"
}

variable "ubuntu_patch_group" {
  description = "patch group to use in tag so that the ubuntu instances are patched"
  default     = ""
}

variable "ssm_agent_policy_arn" {
  description = "policy to apply to instances running ssm agent"
  default     = ""
}

variable "aws_account_id" {
}

variable "aws_region" {
}

variable "private_hosted_zone_id" {
  description = "id of the private hosted zone to create the route53 record for postgres cluster"
}

variable "custom_throughput" {
  default = 0
}

variable "custom_backup_throughput" {
  default = 0
}
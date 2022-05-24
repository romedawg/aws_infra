variable "availability_zone" {}

variable "cluster" {
}

variable "iam_instance_profile_name" {
}

variable "instance_type" {
  description = "specifies the amount CPU and memory allocated to each EC2 instance in consul autoscale group"
}

variable "key_name" {
  description = "Description: Name of the SSH public key to be injected into the host's unix user's authorized_keys file"
}

variable "data_dir_volume_size" {
  description = "Disk Volume in GiB"
}

variable "name" {
  default = "postgres-server"
}

variable "security_group" {
  description = "id of the security group attached to the host"
}

variable "subnet" {
}

variable "custom_iops" {
  default = 0

  validation {
    condition     = var.custom_iops >= 3000 || var.custom_iops == 0
    error_message = "Our gp3 volumes need at least 3000 IOPS (3000 is free)."
  }
}

variable "disk_type" {
  default = "gp3"
}

variable "encrypt_root_block_device" {
  default = true
}

variable "custom_throughput" {
  default = 0
}

variable "cluster-member-identifier" {
  description = "Tag define to identify instance in cluster"
  default     = ""
}
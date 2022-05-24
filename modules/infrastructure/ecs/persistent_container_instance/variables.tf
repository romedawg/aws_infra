variable "environment" {
  description = "environment that the stack is being deployed to"
}

variable "node_id" {
  description = "cluster node id, e.g. 1,2,3,..."
}

variable "key_name" {
  description = "Description: Name of the SSH public key to be injected into the bastion unix user's authorized_keys file"
}

variable "subnet" {
  description = "subnet id that container instance will be deployed into"
}

variable "security_groups" {
  description = "list of security group ids that container instance will use"
  type        = list(string)
}

variable "ecs_service" {
  description = "ECS service name"
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
}

variable "application_cluster" {
  description = "Cluster of EC2 instances, only used as an EC2 tag so that we can group instances"
}

variable "iam_instance_profile_name" {
  description = "Instance profile that container instance will use"
}

variable "data_volume_size" {
  description = "Size of persistent volume in gigabytes"
}

variable "container_uid" {
  description = "UID of container running in container instance"
}

variable "amazonlinux_patch_group" {
  description = "patch group to use in tag so that the ubuntu instances are patched"
  default     = ""
}

variable "instance_type" {
  description = "EC2 Instance type"
}

variable "application_name" {
  description = "Application name"
}

variable "data_volume_type" {
  description = "Volume type for the EBS volume(gp2,gp3,etc.)"
  default     = "gp2"
}

variable "data_volume_iops" {
  description = "iops to provision for the EBS volume"
  default     = 3000
}

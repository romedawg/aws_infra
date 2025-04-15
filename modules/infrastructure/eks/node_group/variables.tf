variable "environment" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "source_security_group_ids" {
  type = list(string)
}

variable "aws_region" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "key_name" {
  type        = string
  description = "Name of the SSH public key to be injected into the bastion unix user's authorized_keys file"
}

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "release_version" {
  type = string
}

variable "initial_cluster_size" {
  description = "Initial size of managed node group. The actual number of nodes is handled by Cluster Autoscaler"
  type        = number
}

variable "ssm_agent_policy_arn" {
  description = "policy to apply to instances running ssm agent"
  default     = ""
}

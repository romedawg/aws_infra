variable "environment" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "node_group_release_version" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "source_security_group_ids" {
  type = list(string)
}

variable "cluster_security_group" {
  description = "security group attached to the EKS control plan"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "key_name" {
  type        = string
  description = "Name of the SSH public key to be injected into the EKS nodes"
}

variable "aws_account_id" {
}

variable "initial_cluster_size" {
  description = "Initial size of managed node group. The actual number of nodes is handled by Cluster Autoscaler"
  type        = number
}

variable "ssm_agent_policy_arn" {
  description = "policy to apply to instances running ssm agent"
  default     = ""
}

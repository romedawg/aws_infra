variable "environment" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "cluster_security_group" {
  description = "security group attached to the EKS control plan"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "kubernetes_version" {
  type = string
}


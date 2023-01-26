variable "environment" {
  description = "the environment to create the task in"
}

variable "ecs_managed_policy_arn" {
  description = "the ecs managed policy arn that is used for all ecs tasks"
}

variable "vpc" {
}

variable "aws_account_id" {
  description = "the id of the aws account used to provision aws resources"
}

variable "aws_region" {
  description = "aws region"
}

variable "key_name" {
  description = "Description: Name of the SSH public key to be injected into the unix user's authorized_keys file"
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
}

variable "iam_instance_profile_name" {
  description = "Instance profile that container instance will use"
}

variable "subnets" {
  description = "list of subnet ids that zookeeper will be deployed into"
  type        = list(string)
}

variable "ssm_agent_policy_arn" {
  description = "policy to apply to instances running ssm agent"
  default     = ""
}

variable "cluster" {}

variable "ami" {}

variable "application_name" {}

variable "route53_zone_id" {}

variable "alb_hostname" {}
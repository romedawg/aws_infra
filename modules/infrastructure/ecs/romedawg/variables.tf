variable "apm_monitoring_disabled" {
  description = "This is an indicator for whether APM monitoring should be disabled.  The value is used when deployments are made using ecs-deploy"
  default     = false
}

variable "environment" {
  description = "the environment to create the service within"
}

variable "vpc" {
  description = "the vpc the service will run in"
}

variable "private_hosted_zone_id" {
  description = "the hosted zone id of the private hosted zone directly managed by terraform"
}

variable "private_hosted_zone_domain_name" {
  description = "the domain name of the private hosted zone domain name"
}

variable "aws_region" {
}

variable "aws_account_id" {
}

variable "security_group_ids" {
  description = "security group ids to attach to the ALB"
  type        = list(string)
}

variable "subnet_ids" {
  description = "subnet ids the ALB will be placed in"
  type        = list(string)
}



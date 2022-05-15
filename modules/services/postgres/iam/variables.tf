variable "aws_account_id" {
}

variable "aws_region" {
}

variable "cluster" {
}

variable "ssm_agent_policy_arn" {
  description = "policy to apply to instances running ssm agent"
  default     = ""
}

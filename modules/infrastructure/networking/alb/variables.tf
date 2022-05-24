variable "environment" {
  description = "environment that the stack is being deployed to"
}

variable "security_groups" {
  description = "id of security group assigned to load balancer"
  type        = list(string)
}

variable "vpc" {
  description = "id of the vpc"
}

variable "subnets" {
  description = "comma-delimited string that contains one or more ids of subnets to be attached to the load balancer"
  type        = list(string)
}

#variable "acm_certificate_arn" {
#  description = "Default certificate for the TLS listener"
#}

variable "internal" {
  description = "specifies whether load balancer is accessible outside a vpc. set to true to only allow access from within the vpc. Set to false to allow access outside the vpc."
}

variable "load_balancer_name" {
}

variable "default_target_group_name" {
}

variable "idle_timeout_seconds" {
  default     = 30
  type        = number
  description = <<EOF
The time in seconds that the connection is allowed to be idle.
See:  https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html#connection-idle-timeout
EOF
}

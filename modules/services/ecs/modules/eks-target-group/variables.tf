variable "environment" {
  description = "the environment the application will be running in"
}

variable "application" {
  description = "name of the application for that the target group routes requests to"
}

variable "port" {
  description = "port on which targets receive traffic, unless overridden when registering a specific target. "
}

variable "health_check_interval_seconds" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds."
  default     = 5
}

variable "health_check_path" {
  description = "destination for the health check request on a target"
  default     = "/"
}

variable "health_check_protocol" {
  description = "protocol to use for ALB health checks, HTTP or HTTPS"
  default     = "HTTP"
}

variable "health_check_timeout_seconds" {
  description = "seconds until healthcheck considered failed"
  default     = 3
}

variable "healthy_threshold" {
  description = "number of consecutive health checks successes required before considering an unhealthy target healthy"
  default     = 3
}

variable "unhealthy_threshold" {
  description = "number of consecutive health check failures required before considering the target unhealthy ."
  default     = 3
}

variable "http_status_codes" {
  default = "200"

  description = <<EOF
The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, "200,202") or a range of values (for example, "200-299").
EOF

}

variable "vpc" {
  description = "the vpc the target group will run within"
}

variable "eks_node_group_autoscale_group" {
  description = "id of the ASG that is managed by EKS managed node group. This is used to register the target grouop with that ASG"
}


variable "environment" {
  description = "the environment the application will be running in"
}

variable "vcs_repository_name" {
  description = "the repository name in our source hosting solution (bitbucket)"
}

variable "health_check_enabled" {
  description = "enable health checking"
  default     = true
}

variable "health_check_interval_seconds" {
  description = "interval between ALB health checks"
  default     = 53
}

variable "health_check_path" {
  description = "path for the ALB to health check"
  default     = "/meta/health"
}

variable "health_check_protocol" {
  description = "protocol to use for ALB health checks, HTTP or HTTPS"
  default     = "HTTP"
}

variable "health_check_timeout_seconds" {
  description = "seconds until healthcheck considered failed"
  default     = 7
}

variable "healthy_threshold_count" {
  description = "the number of consecutive health checks successes required before considering an unhealthy target healthy"
  default     = 2
}

variable "unhealthy_threshold_count" {
  description = "the number of consecutive health checks failures required before considering an target unhealthy"
  default     = 2
}

variable "vpc" {
  description = "the vpc the service will run within"
}

variable "slow_start" {
  default     = 0
  description = <<EOF
!Don't use this is you have issue with ALB health check!
Take a look on health-check-grace-period-seconds property in the ecs-deploy — https://bb.dev.norvax.net/projects/DEP/repos/ecs-deploy/browse/tsk/tsk.go?until=9765e3a44930387abec7a05cc96d2e88642585b4&untilPath=tsk%2Ftsk.go#64
And set this property in ecs-deploy-configuration.

Amount time for targets to warm up before the load balancer sends them a full share of requests.
The range is 30-900 seconds or 0 to disable.
EOF
}

# READ more: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#stickiness
variable "stickiness" {
  description = "the stickiness properties for target group"
  type        = list(object({ type : string, cookie_duration : string, cookie_name : string }))
  default     = []
}

variable "deregistration_delay_seconds" {
  type        = number
  default     = 300
  description = <<EOF
Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused.
The range is 0-3600 seconds.
EOF
}

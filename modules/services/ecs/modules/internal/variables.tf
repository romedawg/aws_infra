variable "environment" {
  description = "the environment the application will be running in"
  type        = string
}

variable "vcs_repository_name" {
  description = "the repository name in our source hosting solution (bitbucket)"
  type        = string
}

variable "health_check_enabled" {
  description = "enable health checking"
  default     = true
}

variable "health_check_interval_seconds" {
  description = "interval between ALB health checks"
  type        = number
  default     = 53
}

variable "port" {
  description = "the port to use when communicating with the application"
  type        = number
}

variable "protocol" {
  description = "path for the ALB to health check"
  type        = string
}

variable "health_check_path" {
  description = "path for the ALB to health check"
  type        = string
  default     = "/meta/health"
}

variable "health_check_protocol" {
  description = "protocol to use for ALB health checks, HTTP or HTTPS"
  type        = string
  default     = "HTTP"
}

variable "health_check_timeout_seconds" {
  description = "seconds until healthcheck considered failed"
  type        = number
  default     = 7
}

variable "health_check_matcher" {
  default = null
}

variable "healthy_threshold_count" {
  description = "number of instances that must be running to be considered healthy"
  type        = number
  default     = 2
}

variable "unhealthy_threshold_count" {
  description = "the number of consecutive health checks failures required before considering an target unhealthy"
  default     = 2
}

variable "vpc" {
  type        = string
  description = "the vpc the service will run within"
}

variable "target_type" {
  type    = string
  default = "ip"
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

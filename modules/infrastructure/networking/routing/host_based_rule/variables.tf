variable "environment" {
  description = "the target environment (i.e. qa, uat, prod)"
}

variable "host_header" {
  description = "the host header the rule will apply to"
}

variable "target_group" {
  description = "the target group that will be routed to"
}

variable "listener" {
  description = "the load balancer listener"
}

variable "tls_listener" {
  description = "the load balancer tls_listener"
}

variable "listener_rule_priority" {
  description = "the priority of the rule"
}


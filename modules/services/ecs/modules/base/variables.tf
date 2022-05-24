variable "apm_monitoring_disabled" {
  description = "This is an indicator for whether APM monitoring should be disabled.  The value is used when deployments are made using ecs-deploy"
  default     = false
}

variable "environment" {
  description = "the environment the application will be running in"
}

variable "vcs_repository_name" {
  description = "the repository name in our source hosting solution (bitbucket)"
}

variable "ecs_managed_policy_arn" {
  description = "the ARN for the ecs managed policy that is attached to all ECS task roles"
}

variable "service_discovery_namespace" {
  description = "the service discovery namespace id"
}

variable "service_discovery_hosted_zone_id" {
  description = "the hosted zone id used by the service discovery namespace"
}

variable "private_hosted_zone_id" {
  description = "the hosted zone id of the private hosted zone directly managed by terraform"
}

variable "service_discovery_hosted_zone_domain_name" {
  description = "the domain name of the service discovery hosted zone"
}

variable "private_hosted_zone_domain_name" {
  description = "the domain name of the private hosted zone domain name"
}


variable "environment" {
  description = "the environment"
}

variable "service_discovery_namespace" {
  description = "the service discovery namespace id"
}

variable "service_discovery_hosted_zone_id" {
  description = "the hosted zone id of the service discovery namespace"
}

variable "service_name" {
  description = "the name of the service to be created"
}

variable "private_hosted_zone_id" {
  description = "the hosted zone id of the terraform managed environment specific hosted zone"
}

variable "service_discovery_hosted_zone_domain_name" {
  description = "the domain name of the service discovery hosted zone"
}

variable "private_hosted_zone_domain_name" {
  description = "the domain name of the private hosted zone"
}


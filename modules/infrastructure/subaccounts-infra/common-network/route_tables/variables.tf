variable "environment" {}
variable "aws_region" {}
variable "vpc_id" {}

variable "access_from_internet" {
  type = bool
}

variable "internet_gateway_id" {
  default = null
}

variable "gohealth_transit_gateway_id" {
  default = null
}

variable "internet_transit_gateway_id" {
  default = null
}

variable "private_prefix_list_ids" {
  type = list(string)
}
variable "public_prefix_list_ids" {
  type = list(string)
}

variable "private_subnet_ids_by_path" {
  type = map(string)
}
variable "public_subnet_ids_by_path" {
  type = map(string)
}

variable "private_additional_tgw_routes" {
  type = list(string)
}

variable "public_additional_tgw_routes" {
  type = list(string)
}

variable "route_all_private_subnets" {
  type = bool
}

variable "private_route_table_association" {
  type        = bool
  default     = false
  description = "Variable used to create routing for AD subnets in IT Infra Account"
}

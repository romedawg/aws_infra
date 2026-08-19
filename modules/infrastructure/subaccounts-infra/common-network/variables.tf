variable "vpc_cidr" {}

variable "environment" {}
variable "system" {}

variable "aws_region" {}
variable "resolver_rule_id" {}

variable "vpc_subnets" {}

variable "private_additional_tgw_routes" {
  type    = list(string)
  default = []
}

variable "public_additional_tgw_routes" {
  type    = list(string)
  default = []
}

variable "private_additional_tgw_routes_prefix_list" {
  type    = list(string)
  default = []
}

variable "public_additional_tgw_routes_prefix_list" {
  type    = list(string)
  default = []
}

variable "rome_transit_gateway_id" {}
variable "internet_transit_gateway_id" {
  default = null
}

variable "access_from_internet" {
  type    = bool
  default = false
}

variable "route_all_private_subnets" {
  type    = bool
  default = false
}

variable "private_route_table_association" {
  type        = bool
  default     = false
  description = "Variable used to create routing for AD subnets in IT Infra Account"
}

# https://gheng.atlassian.net/browse/CLOUD-1949 Capella peering
variable "capella_peering_id" {
  default = null
}

variable "capella_cidr_block" {
  default = null
}

variable "capella_peering_id_uat" {
  default = null
}

variable "capella_cidr_block_uat" {
  default = null
}
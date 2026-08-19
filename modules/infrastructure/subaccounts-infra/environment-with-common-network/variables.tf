variable "vpc_cidr" {}

variable "environment" {}
variable "system" {}
variable "account_id" {
  default = ""
}

variable "aws_region" {}
variable "resolver_rule_id" {}

variable "vpc_subnets" {
}

variable "additional_tgw_routes" {
  type    = list(string)
  default = []
}

variable "additional_tgw_routes_prefixlist" {
  type    = list(string)
  default = []
}

variable "adawsread_dn" {
  type    = string
  default = ""
}

variable "adawsread_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "associated_hosted_zone_ids" {
  type    = list(string)
  default = []
}

variable "newrelic_external_id" {}

variable "newrelic_license_key" {
  description = "NewRelic license key to be used for log ingestion."
}

variable "newrelic_admin_key" {
  description = "NewRelic license key to be used for log ingestion."
}

variable "newrelic_log_ingestion_enable" {
  description = "Enable log ingestion"

  default = false
}

variable "account_name" {}

variable "use_egress_tgw" {
  description = "Configure network egress account for internet traffic"
  default     = false
}

variable "egress_tgw_id" {
  # default     = "tgw-050211180566efc3a"
  description = "GH network account used for egress traffic"
}

variable "route_all_private_subnets" {
  default = false
}

variable "access_from_internet" {
  default = true
}

variable "store_nr_license_key_to_secret_manager" {
  description = "Flag whether to store new relic license key in secret manager"
  default     = false
}

variable "store_nr_license_key_to_ssm" {
  description = "Flag whether to store new relic license key in ssm parameter store"
  default     = false
}

variable "private_route_table_association" {
  type        = bool
  default     = false
  description = "Variable used to create routing for AD subnets in IT Infra Account"
}

variable "newrelic_metric_stream_namespaces" {
  type    = list(string)
  default = []
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


variable "kms_cross_account_principals" {
  description = "List of external AWS account IDs granted KMS decrypt/encrypt access (e.g. Zscaler scanning)"
  type        = list(string)
  default     = []
}

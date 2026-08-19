variable "vpc_id" {
}

variable "resolver_rule_id" {
}

variable "hosted_zone_ids" {
  type    = list(string)
  default = []
}
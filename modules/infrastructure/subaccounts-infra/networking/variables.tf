variable "vpc_cidr" {}
variable "availability_zone" {}

variable "environment" {}
variable "system" {}

variable "aws_region" {}
variable "resolver_rule_id" {}

variable "vpc_subnet_cidr_blocks" {
  type = object({
    private_us_east_2a = string
    private_us_east_2b = string
    private_us_east_2c = string
    public_us_east_2a  = string
    public_us_east_2b  = string
    public_us_east_2c  = string
    tgw_us_east_2a     = string
    tgw_us_east_2b     = string
    tgw_us_east_2c     = string
  })
}

variable "additional_tgw_routes" {
  type    = list(string)
  default = []
}

variable "account_name" {}

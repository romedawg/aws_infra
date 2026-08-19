variable "environment" {}
variable "system" {}
variable "vpc_id" {}

variable "availability_zones" {
  type = object({
    z2a = string
    z2b = string
    z2c = string
  })
}

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

variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "route_table_ids" {
  type = map(string)
}

variable "access_from_internet" {
  type    = bool
  default = false
}
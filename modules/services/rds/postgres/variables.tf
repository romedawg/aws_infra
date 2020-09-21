variable "database_name" {}
variable "allocated_storage" {}
variable "storage_type" {
  default = "gp2"
}
variable "engine" {}
variable "engine_version" {}
variable "environment" {}
variable "instance_class" {}
variable "port" {}
variable "backup_retention_period" {}
variable "backup_window" {}
variable "maintenance_window" {}
variable "security_group_id" {}
variable "pg_family" {}
variable "subnet_group" {
  type = list(string)
}

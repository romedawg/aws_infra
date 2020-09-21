variable "database_name" {
  description = "The name of the database"
}

variable "environment" {
  description = "qa, uat, prod, etc."
}
variable "pg_family" {}
variable "engine" {}
variable "engine_version" {}

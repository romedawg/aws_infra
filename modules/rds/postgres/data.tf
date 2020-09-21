data "aws_ssm_parameter" "postgres_password" {
  name = format("/%s/postgres/admin_password", var.environment)
}

data "aws_security_group" "postgres_rds_sg" {

  id = var.security_group_id
}

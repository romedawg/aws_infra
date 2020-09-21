resource "aws_db_parameter_group" "pg" {
  name   = "${var.environment}-pg-${var.database_name}"
  family = var.pg_family

  tags = {
    database-name = var.database_name
    environment   = var.environment
  }

}

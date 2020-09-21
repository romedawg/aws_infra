module "paramater_group" {
  source         = "parameter_group"
  database_name  = var.database_name
  environment    = var.environment
  engine         = var.engine
  engine_version = var.engine_version
  pg_family      = var.pg_family
}

resource "aws_db_subnet_group" "postgres_db_subnet_group" {
  name       = "${var.environment}-postgres_db_subnet_group"
  subnet_ids = var.subnet_group

  tags = {
    Name        = "postgres_db_subnet_group"
    environment = var.environment
  }
}

resource "aws_db_instance" "postgres_db" {
  allocated_storage               = var.allocated_storage
  allow_major_version_upgrade     = false
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.backup_window
  maintenance_window              = var.maintenance_window
  enabled_cloudwatch_logs_exports = ["postgresql"]
  deletion_protection             = true
  multi_az                        = true
  storage_type                    = var.storage_type
  engine                          = var.engine
  engine_version                  = var.engine_version
  instance_class                  = var.instance_class
  name                            = var.database_name
  username                        = "postgres"
  password                        = data.aws_ssm_parameter.postgres_password.value
  port                            = var.port
  parameter_group_name            = module.paramater_group.name
  db_subnet_group_name            = aws_db_subnet_group.postgres_db_subnet_group.name
}

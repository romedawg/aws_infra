output "service" {
  value = {
    task_role                = aws_iam_role.ecs_taskrole.id
    task_role_arn            = aws_iam_role.ecs_taskrole.arn
    service_registry_arn     = module.private_service_discovery_service.arn
    domain_name              = module.private_service_discovery_service.domain
    task_role_name           = aws_iam_role.ecs_taskrole.name
    task_role_migration_name = aws_iam_role.ecs_taskrole_migration.name
    task_role_migration      = aws_iam_role.ecs_taskrole_migration.id
    task_role_migration_arn  = aws_iam_role.ecs_taskrole_migration.arn
    monitoring_disabled      = var.apm_monitoring_disabled
  }
}


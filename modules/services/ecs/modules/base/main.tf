#
# This module will sets up the base of a service running in ECS.
#

resource "aws_iam_role" "ecs_taskrole" {
  name = local.short_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "ecs_taskrole_attachment_one" {
  role       = aws_iam_role.ecs_taskrole.name
  policy_arn = var.ecs_managed_policy_arn
}

resource "aws_iam_role" "ecs_taskrole_migration" {
  name = local.short_name_migration

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "ecs_taskrole_migration_attachment_one" {
  role       = aws_iam_role.ecs_taskrole_migration.name
  policy_arn = var.ecs_managed_policy_arn
}

module "private_service_discovery_service" {
  source                                    = "../../../../infrastructure/service_discovery/service"
  service_name                              = var.vcs_repository_name
  environment                               = var.environment
  service_discovery_namespace               = var.service_discovery_namespace
  service_discovery_hosted_zone_id          = var.service_discovery_hosted_zone_id
  private_hosted_zone_id                    = var.private_hosted_zone_id
  service_discovery_hosted_zone_domain_name = var.service_discovery_hosted_zone_domain_name
  private_hosted_zone_domain_name           = var.private_hosted_zone_domain_name
}


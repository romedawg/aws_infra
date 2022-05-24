locals {
  ecs_service_tag = {
    "ecs_${var.ecs_service}" = "true"
  }
}


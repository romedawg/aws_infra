locals {
  ami_owner = "amazon"
  ami_name  = "amzn2-ami-ecs-hvm-2.0.20200218-x86_64-ebs"

  ecs_service_tag = {
    "ecs_${var.ecs_service}" = "true"
  }
}


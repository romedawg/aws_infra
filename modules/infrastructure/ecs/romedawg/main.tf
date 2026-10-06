module "base" {
  source                  = "../modules/base"
  name                    = "romedawg"
  apm_monitoring_disabled = var.apm_monitoring_disabled
  # service_discovery_hosted_zone_id          = var.service_discovery_hosted_zone_id
  # service_discovery_hosted_zone_domain_name = var.service_discovery_hosted_zone_domain_name
  private_hosted_zone_domain_name = var.private_hosted_zone_domain_name
  # service_discovery_namespace               = var.service_discovery_namespace
  environment            = var.environment
  vcs_repository_name    = local.vcs_repository_name
  ecs_managed_policy_arn = aws_iam_policy.elastic_container_service.arn
  private_hosted_zone_id = var.private_hosted_zone_id
}

module "internal" {
  source                        = "../modules/internal"
  name                          = "romedawg"
  vpc                           = var.vpc
  health_check_path             = "/actuator/health"
  health_check_matcher          = "200-499"
  port                          = 8080
  protocol                      = "HTTP"
  vcs_repository_name           = local.vcs_repository_name
  environment                   = var.environment
  health_check_interval_seconds = 120
  health_check_timeout_seconds  = 30
}


resource "aws_lb" "romedawg" {
  name               = "romedawg-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    application        = "romedawg"
    configuration_item = "romedawg"
    Environment        = var.environment
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.romedawg.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


resource "aws_lb_listener" "romedawg_https" {
  load_balancer_arn = aws_lb.romedawg.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = "arn:aws:acm:us-east-2:701164309191:certificate/d43d123c-1241-443b-b3bf-389465ab0292"

  default_action {
    type             = "forward"
    target_group_arn = module.internal.target_group_arn
  }
}

resource "aws_lb_listener_rule" "romedawg_http" {
  listener_arn = aws_lb_listener.romedawg_https.arn

  action {
    type             = "forward"
    target_group_arn = module.internal.target_group_arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "aws_route53_record" "private" {
  zone_id = var.private_hosted_zone_id
  name    = "romedawg.com"
  type    = "CNAME"
  ttl     = 5
  records = [aws_lb.romedawg.dns_name]
}

## TODO
// Namespace for the service discovery
// LogGroup error

resource "random_integer" "new_relic_account_id" {
  min = 1000000
  max = 9999999
}

resource "random_password" "new_relic_insights_api_insert_key" {
  length  = 40
  special = false
}

resource "random_password" "nexus_password" {
  length  = 32
  special = false
}

resource "aws_ssm_parameter" "new_relic_account_id" {
  name  = "/all/new_relic/account_id"
  type  = "String"
  value = tostring(random_integer.new_relic_account_id.result)
}

resource "aws_ssm_parameter" "new_relic_insights_api_insert_key" {
  name  = "/all/new_relic/insights_api_insert_key"
  type  = "SecureString"
  value = random_password.new_relic_insights_api_insert_key.result
}


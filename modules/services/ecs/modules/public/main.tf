#
# This module can be used in addition to the "base" module to allocate the additional resources needed so that it can
# be exposed publicly through the public ALB.
#

resource "random_id" "name_suffix" {
  byte_length = 6
}

// We need a unique name for the target group otherwise we will have name conflicts.
// However, name_prefix won't work because the max length for a prefix is 6 characters.
resource "aws_lb_target_group" "external_application" {
  name        = "${var.environment}-public-${random_id.name_suffix.hex}"
  protocol    = "HTTP"
  port        = 8080
  vpc_id      = var.vpc
  target_type = "ip"
  slow_start  = var.slow_start

  health_check {
    enabled             = var.health_check_enabled
    interval            = var.health_check_interval_seconds
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout_seconds
    healthy_threshold   = var.healthy_threshold_count
    unhealthy_threshold = var.unhealthy_threshold_count
  }

  deregistration_delay = var.deregistration_delay_seconds

  dynamic "stickiness" {
    for_each = var.stickiness
    iterator = it
    content {
      type            = it.value.type
      cookie_duration = it.value.cookie_duration
      cookie_name     = it.value.cookie_name
    }
  }

  tags = {
    application = var.vcs_repository_name
  }
}

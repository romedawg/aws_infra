#
# This module can be used in addition to the "base" module to allocate the additional resources needed so that it can
# be exposed publicly through the public ALB.
#

resource "random_id" "name_suffix" {
  byte_length = 6
}

// We need a unique name for the target group otherwise we will have name conflicts.
// However, name_prefix won't work because the max length for a prefix is 6 characters.
resource "aws_lb_target_group" "eks" {
  name        = "${var.environment}-eks-${random_id.name_suffix.hex}"
  protocol    = "HTTP"
  port        = var.port
  vpc_id      = var.vpc
  target_type = "instance"

  health_check {
    interval            = var.health_check_interval_seconds
    path                = var.health_check_path
    protocol            = "HTTP"
    timeout             = var.health_check_timeout_seconds
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.http_status_codes
  }

  tags = {
    application = var.application
  }
}

resource "aws_autoscaling_attachment" "eks_managed_node_group" {
  autoscaling_group_name = var.eks_node_group_autoscale_group
  alb_target_group_arn   = aws_lb_target_group.eks.arn
}


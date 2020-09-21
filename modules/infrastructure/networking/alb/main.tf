resource "aws_lb" "public" {
  internal           = var.internal
  load_balancer_type = "application"
  name               = var.load_balancer_name

  security_groups = var.security_groups

  subnets = var.subnets

  idle_timeout = var.idle_timeout_seconds
}

resource "aws_lb_target_group" "default_drop" {
  name     = var.default_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc

  health_check {
    interval            = 6
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.public.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_drop.arn
  }
}

# For details about SSL policy, see:
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html

resource "aws_lb_listener" "tls_front_end" {
  load_balancer_arn = aws_lb.public.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_drop.arn
  }
}


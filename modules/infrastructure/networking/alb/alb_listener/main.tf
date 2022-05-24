# For details about SSL policy, see:
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html

resource "aws_lb_listener" "tls_front_end" {
  load_balancer_arn = var.alb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.default_drop_arn
  }
}
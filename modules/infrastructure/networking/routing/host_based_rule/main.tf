resource "aws_lb_listener_rule" "tls" {
  listener_arn = var.tls_listener
  priority     = var.listener_rule_priority

  action {
    type             = "forward"
    target_group_arn = var.target_group
  }

  condition {
    host_header {
      values = [var.host_header]
    }
  }
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = var.listener
  priority     = var.listener_rule_priority

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = [var.host_header]
    }
  }

  depends_on = [aws_lb_listener_rule.tls]
}

output "service" {
  value = {
    target_group = aws_lb_target_group.external_application.id
  }
}


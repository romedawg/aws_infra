output "service" {
  value = {
    target_group = aws_lb_target_group.internal_application.id
  }
}

output "target_group_arn" {
  value = aws_lb_target_group.internal_application.arn
}

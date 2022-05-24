output "public_alb_arn" {
  value = aws_lb.public.arn
}

output "dns" {
  value = aws_lb.public.dns_name
}

output "listener" {
  value = aws_lb_listener.front_end.id
}

#output "tls_listener" {
#  value = aws_lb_listener.alb_listener.id
#}
#
#
#output "tls_listener_arn" {
#  value = aws_lb_listener.alb_listener.arn
#}

output "canonical_hosted_zone_id" {
  value = aws_lb.public.zone_id
}

output "default_drop_target_group_arn" {
  value = aws_lb_target_group.default_drop.arn
}



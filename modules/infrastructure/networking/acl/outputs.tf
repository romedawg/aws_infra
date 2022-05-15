output "bastion_security_group_id" {
  value = aws_security_group.bastion.id
}

output "alb_security_group_id" {
  value = aws_security_group.alb-public.id
}

output "postgres_security_group_id" {
  value = aws_security_group.postgres.id
}
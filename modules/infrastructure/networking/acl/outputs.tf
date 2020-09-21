output "postgres_rds_security_group" {
  description = "id of the security group allowing connections to a typical Postgres RDS"
  value       = aws_security_group.postgres_rds.id
}

output "bastion_security_group" {
  value = aws_security_group.bastion.id
}


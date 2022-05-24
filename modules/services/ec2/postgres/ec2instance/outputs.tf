output "ec2_id" {
  value = aws_instance.postgres_server.id
}

output "ec2_private_ip" {
  value = aws_instance.postgres_server.private_ip
}

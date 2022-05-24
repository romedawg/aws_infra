output "private_ip" {
  value = aws_instance.container_instance.private_ip
}

output "instance_id" {
  value = aws_instance.container_instance.id
}

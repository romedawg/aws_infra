output "romedawg_id" {
  value = aws_instance.romedawg_ec2.id
}

output "public_ip" {
  value = aws_eip.romedawg_eip.public_ip
}

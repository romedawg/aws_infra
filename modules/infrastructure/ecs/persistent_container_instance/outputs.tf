output "private_ip" {
  value = aws_instance.container_instance.private_ip
}

output "eni_private_ip" {
  value = tolist(aws_network_interface.eni.private_ips)[0]
}


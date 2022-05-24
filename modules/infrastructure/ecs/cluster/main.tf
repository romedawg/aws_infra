resource "aws_ecs_cluster" "rome" {
  name = "rome"
}

output "name" {
  description = "id of the ecs cluster"
  value       = aws_ecs_cluster.rome.id
}

output "arn" {
  description = "arn of the ecs cluster"
  value       = aws_ecs_cluster.rome.arn
}


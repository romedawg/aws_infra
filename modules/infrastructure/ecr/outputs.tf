output "ecr_url" {
  value = aws_ecr_repository.public_ecr.repository_url
}
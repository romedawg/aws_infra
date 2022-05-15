resource "aws_ecr_repository" "public_ecr" {
  name                 = "public-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
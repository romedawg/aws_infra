resource "aws_internet_gateway" "igw" {
  count  = var.access_from_internet ? 1 : 0
  vpc_id = var.vpc_id
}

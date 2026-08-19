module "subnets" {
  for_each = var.vpc_subnets
  source   = "../subnets"

  vpc_id      = var.vpc_id
  environment = var.environment

  aws_region = var.aws_region
  zone       = each.key
  subnets    = each.value
}

resource "aws_subnet" "private_us_east_2a" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_subnet_cidr_blocks.private_us_east_2a

  availability_zone = var.availability_zones.z2a

  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateUsEast2a"
  }
}

resource "aws_subnet" "private_us_east_2b" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_subnet_cidr_blocks.private_us_east_2b

  availability_zone = var.availability_zones.z2b

  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateUsEast2b"
  }
}

resource "aws_subnet" "private_us_east_2c" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_subnet_cidr_blocks.private_us_east_2c

  availability_zone = var.availability_zones.z2c

  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateUsEast2c"
  }
}

resource "aws_subnet" "public_us_east_2a" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_subnet_cidr_blocks.public_us_east_2a

  availability_zone = var.availability_zones.z2a

  map_public_ip_on_launch = false

  tags = {
    Name = "PublicUsEast2a"
  }
}

resource "aws_subnet" "public_us_east_2b" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_subnet_cidr_blocks.public_us_east_2b

  availability_zone = var.availability_zones.z2b

  map_public_ip_on_launch = false

  tags = {
    Name = "PublicUsEast2b"
  }
}

resource "aws_subnet" "public_us_east_2c" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_subnet_cidr_blocks.public_us_east_2c

  availability_zone = var.availability_zones.z2c

  map_public_ip_on_launch = false

  tags = {
    Name = "PublicUsEast2c"
  }
}

resource "aws_subnet" "tgw_us_east_2a" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_subnet_cidr_blocks.tgw_us_east_2a

  availability_zone = var.availability_zones.z2a

  map_public_ip_on_launch = false

  tags = {
    Name = "TGW-UsEast2a"
  }
}

resource "aws_subnet" "tgw_us_east_2b" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_subnet_cidr_blocks.tgw_us_east_2b

  availability_zone = var.availability_zones.z2b

  map_public_ip_on_launch = false

  tags = {
    Name = "TGW-UsEast2b"
  }
}

resource "aws_subnet" "tgw_us_east_2c" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpc_subnet_cidr_blocks.tgw_us_east_2c

  availability_zone = var.availability_zones.z2c

  map_public_ip_on_launch = false

  tags = {
    Name = "TGW-UsEast2c"
  }
}

resource "aws_eip" "public_us_east_2a_eip" {
  domain = "vpc"
}

resource "aws_eip" "public_us_east_2b_eip" {
  domain = "vpc"
}

resource "aws_eip" "public_us_east_2c_eip" {
  domain = "vpc"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.system}-${var.environment}-IGW"
  }
}

resource "aws_nat_gateway" "public_us_east_2a_nat_gateway" {
  allocation_id = aws_eip.public_us_east_2a_eip.id
  subnet_id     = var.public_us_east_2a_subnet_id

  tags = {
    Name = "${var.system}-${var.environment}-NAT-PublicUsEast2a"
  }
}

resource "aws_nat_gateway" "public_us_east_2b_nat_gateway" {
  allocation_id = aws_eip.public_us_east_2b_eip.id
  subnet_id     = var.public_us_east_2b_subnet_id

  tags = {
    Name = "${var.system}-${var.environment}-NAT-PublicUsEast2b"
  }
}

resource "aws_nat_gateway" "public_us_east_2c_nat_gateway" {
  allocation_id = aws_eip.public_us_east_2c_eip.id
  subnet_id     = var.public_us_east_2c_subnet_id

  tags = {
    Name = "${var.system}-${var.environment}-NAT-PublicUsEast2c"
  }
}

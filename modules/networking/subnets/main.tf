resource "aws_subnet" "data_one" {
  vpc_id     = var.vpc_id
  cidr_block = "10.31.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "data_one"
  }
}

resource "aws_subnet" "data_two" {
  vpc_id     = var.vpc_id
  cidr_block = "10.31.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "data_two"
  }
}

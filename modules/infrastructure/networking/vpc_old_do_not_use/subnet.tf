resource "aws_subnet" "data_one" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  depends_on              = [aws_internet_gateway.gateway]

  tags = {
    Name = "data_one"
  }
}

resource "aws_subnet" "data_two" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.31.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  depends_on              = [aws_internet_gateway.gateway]

  tags = {
    Name = "data_two"
  }
}

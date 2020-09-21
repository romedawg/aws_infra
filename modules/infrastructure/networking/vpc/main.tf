resource "aws_vpc" "vpc" {
  cidr_block = "10.31.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_egress_only_internet_gateway" "egress" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main_gw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "Data one route table"
  }
}

resource "aws_main_route_table_association" "route_table_asso" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route" "route" {
  route_table_id              = aws_route_table.route_table.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.egress.id
}


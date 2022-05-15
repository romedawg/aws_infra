resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.50.0.0/16"
  enable_dns_hostnames = true
}

# attach gateway to vpc_old_do_not_use so traffic can be routed in and out of the vpc_old_do_not_use
// internet gateway/attach
resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main_gw"
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main_vpc.id
  route_table_id = aws_route_table.public_route_table.id
}

//   # Create a route table and attach the table to internet gateway.
//  # Any subnet that has this route table can route traffic through the gateway
//  # and thus communicate with systems outside the VPC.
//  # Any subnet that uses this route table is thus considered a public subnet.
// public route/table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gateway.id
  }

  tags = {
    Name = "main_route_table"
  }
}

// Subnet data
module "subnets" {
  source = "./subnets"
  vpc_id =  aws_vpc.main_vpc.id
  region = var.region

  main_gateway_id = aws_internet_gateway.main_gateway.id
}
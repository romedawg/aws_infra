// vpc
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.30.0.0/16"
  enable_dns_hostnames = true
}

# attach gateway to vpc so traffic can be routed in and out of the vpc
// internet gateway/attach
resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main_gw"
  }
}

// Provides a resource to create a VPC Internet Gateway Attachment.
#resource "aws_internet_gateway_attachment" "main_gateway" {
#  internet_gateway_id = aws_internet_gateway.main_gateway.id
#  vpc_id              = aws_vpc.main_vpc.id
#}

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

# Network topology will be split across two availability zones (AZ) for geographic redundancy.
# This requires that whatever network infrastructure is deployed in one AZ is also deployed in the other.

########################
# Availability Zone: 0 #
#######################

# create public subnet by associating it with the public route table defined above.
// public subnet/route table
resource "aws_subnet" "public_subnet"{
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.30.0.0/24"
  map_public_ip_on_launch = true
}

#resource "aws_route_table" "public_subnet_route_table" {
#  vpc_id = aws_vpc.main_vpc.id
#
#  route {
#    cidr_block = aws_subnet.public_subnet.cidr_block
#    gateway_id = aws_internet_gateway.main_gateway.id
#  }
#
#  tags = {
#    Name = "main_route_table"
#  }
#}

# Add a NAT gateway to the public subnet so that private subnets can route traffic outside the VPC.
# this requires first creating an Elastic IP and then associating that EIP with the nat gateway
// EIP
#resource "aws_eip" "main_eip" {
#
#}

// NAT Gateway

# Create a private subnet for handling Elastic Container Service traffic.
# All network IO for containers will occur on this subnet.
# No direct external access to this network is permitted.
# Ingress must come through gateway -> ELB -> public subnet.
# Egress to outside the VPC will be through the NAT gateway.
// ECS Subnet/route table

# Create a private subnet for services that have state (e.g Consul, Couchbase, Mysql)
# This subnet will only contain EC2 instances with EBS.
# No external access to this network is permitted. All access must be from a subnet within the vpc.
# Egress outside the VPC will be through the NAT gateway.
// private subnet/route table
resource "aws_subnet" "private_subnet"{
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.30.2.0/24"
  map_public_ip_on_launch = true
}


# Create a private subnet for the internal ALB that will route traffic within the VPC from one service to another.
# This subnet will only contain EC2 instances with EBS.
# No external access to this network is permitted. All access must be from a subnet within the vpc.
# Egress outside the VPC will be through the NAT gateway.
// Internal ALB Subnet/route table


# Create a private subnet for services that provide access to secrets.
# Currently, the only service that should be deployed here is hashicorp vault.
# This subnet will only contain EC2 instances with EBS.
# No external access to this network is permitted. All access must be from a subnet within the vpc.
# Egress outside the VPC will be through the NAT gateway.
// Secrets Subnet/route table

# Network topology will be split across two availability zones (AZ) for geographic redundancy.
# This requires that whatever network infrastructure is deployed in one AZ is also deployed in the other.

########################
# Availability Zone: 0 #
#######################

# create public subnet by associating it with the public route table defined above.
// public subnet/route table
resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.30.0.0/24"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "acme_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.30.2.0/24"
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "acme_subnet"
  }

}

// I dont really need this right now(EIP and private subnet)
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
# No external access to this network is permitted. All access must be from a subnet within the vpc_old_do_not_use.
# Egress outside the VPC will be through the NAT gateway.
// private subnet/route table
#resource "aws_subnet" "private_subnet" {
#  vpc_id                  = aws_vpc.main_vpc.id
#  cidr_block              = "10.30.2.0/24"
#  vailability_zone = "us-east-1c"
# map_public_ip_on_launch = true
#
# tags = {
#   Name = "private_subnet"
# }


# Create a private subnet for the internal ALB that will route traffic within the VPC from one service to another.
# This subnet will only contain EC2 instances with EBS.
# No external access to this network is permitted. All access must be from a subnet within the vpc_old_do_not_use.
# Egress outside the VPC will be through the NAT gateway.
// Internal ALB Subnet/route table


# Create a private subnet for services that provide access to secrets.
# Currently, the only service that should be deployed here is hashicorp vault.
# This subnet will only contain EC2 instances with EBS.
# No external access to this network is permitted. All access must be from a subnet within the vpc_old_do_not_use.
# Egress outside the VPC will be through the NAT gateway.
// Secrets Subnet/route table

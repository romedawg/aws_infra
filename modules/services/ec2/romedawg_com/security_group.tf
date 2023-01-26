resource "aws_security_group" "generic_security_group" {
  name        = "security-group-${var.application_name}"
  description = "Allow SSH access to the container instance node from whitelist source IP"
  vpc_id      = var.vpc

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8", "24.15.4.0/24"]
  }

  // Amazon docs are misleading, if port is set to 8. AWS will set protocol to  Echo Request(also need Echo Reply).
  // Need the Security Group set to the AWS equivalant of Type: All ICMP - IPv4, Protoco: All, Port Range: 0 - 65535.
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/8"]
  }


  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    description = "internal ALB access any app on port 8080"
    cidr_blocks = ["10.0.0.0/8", "24.15.4.0/24"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "internal ALB access any app on port 8080"
    cidr_blocks = ["10.0.0.0/8", "24.15.4.0/24"]
  }

  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"

    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }


}


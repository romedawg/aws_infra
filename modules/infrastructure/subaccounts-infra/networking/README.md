 Module for Gohealth Network account to serve as egress internet access
 - VPC
 - Subnets
 - Route tables
 - Transit gateway
 - Egress VPC + NAT gateways

TGW + Route tables for it are created through Terraform-AWS-All-EVNs as a shared resource

# NOTE! when you create this, you need to populate the tgw id into any subaccounts that need egress NAT tables



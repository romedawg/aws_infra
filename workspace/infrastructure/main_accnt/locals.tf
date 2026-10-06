locals {
  aws_account_id = 701164309191
  aws_region     = "us-east-2"
  environment    = "dev"
  ssh_key_name   = "roman_aws"
  romedawg_com_hosted_zone_id = "Z04258462YW3S2D7DVB4A"
  romedawg_com_hosted_zone_name = "romedawg.com"


  vpc_cidr     = "10.30.101.0/24"

  vpc_subnets = {
    a = {
      Public  = "10.30.101.128/28"
      Private = "10.30.101.0/27"
      TGW     = "10.30.101.192/28"
    }
    b = {
      Public  = "10.30.101.144/28"
      Private = "10.30.101.32/27"
      TGW     = "10.30.101.208/28"
    }
    c = {
      Public  = "10.30.101.160/28"
      Private = "10.30.101.64/27"
      TGW     = "10.30.101.224/28"
    }
  }
}

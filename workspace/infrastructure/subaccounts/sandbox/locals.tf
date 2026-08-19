# locals {
#   aws_account_id = 024441264067
#   aws_region     = "us-east-2"
#   environment    = "dev"
# }


locals {
  main_accnt_prefix_list_id = "pl-00b29bd1eeae9e00c"       // Main aws account corp_ops prefix list
  resolver_rule_id          = "rslvr-rr-dbb645ff5e744dc0a" // romedawg_all resolver

  romedawg_hosted_zone = "Z04258462YW3S2D7DVB4A"
  # env_svc_hosted_zone = "Z365ZHFXF7BRUH"
  # env_hosted_zone     = "Z1H7IKVP64N7IS"

  ssh_key_name = "roman_aws"
  environment  = "qa"
  system       = "sandbox"
  aws_region   = "us-east-2"
  vpc_cidr     = "10.36.101.0/24"

  vpc_subnets = {
    a = {
      Public  = "10.36.101.128/28"
      Private = "10.36.101.0/27"
      TGW     = "10.36.101.192/28"
    }
    b = {
      Public  = "10.36.101.144/28"
      Private = "10.36.101.32/27"
      TGW     = "10.36.101.208/28"
    }
    c = {
      Public  = "10.36.101.160/28"
      Private = "10.36.101.64/27"
      TGW     = "10.36.101.224/28"
    }
  }
}

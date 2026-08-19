locals {
  // romedawg_all resolver - only used as an example, not really necessary for testing use case
  // manually creates in root account, need to defined outbout endpoints for this to work properly(AD/dns resolvers)
  resolver_rule_id = "rslvr-rr-dbb645ff5e744dc0a"

  environment = "networking"
  system      = "rome_networking"
  aws_region  = "us-east-2"


  // AWS account ids to share TGW
  sub_account_ids = [
    "024441264067", // sandbox
    # "", // qa
  ]
  vpc_cidr = "10.36.94.0/24"

  vpc_subnet_cidr_blocks = {
    private_us_east_2a = "10.36.94.0/27"
    public_us_east_2a  = "10.36.94.128/28"
    tgw_us_east_2a     = "10.36.94.192/28"
    private_us_east_2b = "10.36.94.32/27"
    public_us_east_2b  = "10.36.94.144/28"
    tgw_us_east_2b     = "10.36.94.208/28"
    private_us_east_2c = "10.36.94.64/27"
    public_us_east_2c  = "10.36.94.160/28"
    tgw_us_east_2c     = "10.36.94.224/28"
  }

  ## old cidr group
  # vpc_cidr = "10.36.100.0/24"
  #
  # vpc_subnet_cidr_blocks = {
  #   private_us_east_2a = "10.36.100.0/27"
  #   private_us_east_2b = "10.36.100.32/27"
  #   private_us_east_2c = "10.36.100.64/27"
  #   public_us_east_2a  = "10.36.100.96/27"
  #   public_us_east_2b  = "10.36.100.128/27"
  #   public_us_east_2c  = "10.36.100.160/27"
  # }

  # INITIAL or FINAL.
  deployment_step = "FINAL"

}

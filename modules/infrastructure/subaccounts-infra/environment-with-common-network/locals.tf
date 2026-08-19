locals {
  root_account_id             = "453357546588"
  transit_gateway_id          = "tgw-0aab2822b808fe8d7" //Main aws account TGW
  corp_and_ops_prefix_list_id = "pl-0694fe15105d1ac34"  //Main aws account corp_ops prefix list

  rome_transit_gateway_id     = "tgw-0aab2822b808fe8d7"
  internet_transit_gateway_id = "tgw-0cf24c00e8c24a4d5"

  availability_zones = {
    z2a = "us-east-2a"
    z2b = "us-east-2b"
    z2c = "us-east-2c"
  }
}

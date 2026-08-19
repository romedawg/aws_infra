locals {

  # TODO fix networking in main account
  # Public Subnets(1,2,3) Each subnet is in a different availability zone
  ops_subnet_ids = [
    "subnet-0b6a3aaff5046936b",
  ]


  vpc_id = {

    ops = "vpc-086d572573c623f5d"
  }

  vpc_attachment_ids = concat([
    module.ops_vpc_attachment.attachment_id,
  ], var.subaccount_tgw_attachments)

}

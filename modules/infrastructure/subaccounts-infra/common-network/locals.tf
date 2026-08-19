locals {
  subnet_indexes = flatten([
    for k, v in var.vpc_subnets : [
      for k1, v1 in v : "${k}___${k1}"
    ]
  ])

  private_subnet_indexes = flatten([
    for k, v in var.vpc_subnets : [
      for k1, v1 in v : "${k}___${k1}" if k1 != "Public" && k1 != "TGW"
    ]
  ])
  public_subnet_indexes = flatten([
    for k, v in var.vpc_subnets : [
      for k1, v1 in v : "${k}___${k1}" if k1 == "Public" && v1 != null
    ]
  ])
  tgw_subnet_indexes = flatten([
    for k, v in var.vpc_subnets : [
      for k1, v1 in v : "${k}___${k1}" if k1 == "TGW"
    ]
  ])

  private_subnet_ids_by_path = {
    for v in local.private_subnet_indexes :
    v => module.az_subnets.subnet_ids_grouped_by_path[v]
  }
  public_subnet_ids_by_path = {
    for v in local.public_subnet_indexes :
    v => tostring(module.az_subnets.subnet_ids_grouped_by_path[v])
  }
  tgw_subnet_ids_by_path = {
    for v in local.tgw_subnet_indexes :
    v => tostring(module.az_subnets.subnet_ids_grouped_by_path[v])
  }

  private_subnet_ids = values(tomap(local.private_subnet_ids_by_path))
  public_subnet_ids  = values(local.public_subnet_ids_by_path)

  root_account_id = "453357546588"
}

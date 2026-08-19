locals {
  subnet_ids_by_path = merge(values(module.subnets)[*].subnet_ids_grouped_by_path...)

  subnet_ids_by_prefix = {
    for k, v in local.subnet_ids_by_path :
    split("___", k)[1] => v...
  }

  indexes = flatten([
    for k, v in var.vpc_subnets : [
      for k1, v1 in v : "${k}___${k1}"
    ]
  ])
}
output "accounts" {
  value = merge(


    module.network.account_info,
    module.sandbox.account_info,
  )
}

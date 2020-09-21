#module "romedawg_com" {
#  source                 = "../host_based_rule"
#  host_header            = "specifications.${local.environment_url_base}"
#  environment            = var.environment
#  listener               = var.listener_arn
#  tls_listener           = var.tls_listener_arn
#  listener_rule_priority = local.priority_rules["executable_documentation_website"]
#  target_group           = var.target_groups["executable_documentation_website"]
#}

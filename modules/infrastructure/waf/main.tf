resource "aws_fms_policy" "policy" {
  name = "global-waf-${var.environment}"

  delete_all_policy_resources        = true
  delete_unused_fm_managed_resources = true
  remediation_enabled                = true
  exclude_resource_tags              = false

  resource_type = "AWS::ApiGateway::Stage"
  include_map {
    account = var.accounts
    orgunit = []
  }

  security_service_policy_data {
    type = "WAFV2"

    managed_service_data = jsonencode({
      defaultAction = {
        type = "ALLOW"
      }
      optimizeUnassociatedWebACL        = true
      overrideCustomerWebACLAssociation = false
      postProcessRuleGroups             = []
      preProcessRuleGroups = [
        {
          excludeRules               = []
          managedRuleGroupIdentifier = null
          overrideAction = {
            type = "NONE"
          }
          ruleGroupArn           = aws_wafv2_rule_group.block_bad_actors.arn
          ruleGroupType          = "RuleGroup"
          sampledRequestsEnabled = true
        },
        {
          excludeRules = []
          managedRuleGroupIdentifier = {
            vendorName           = "AWS"
            managedRuleGroupName = "AWSManagedRulesCommonRuleSet"
          }
          overrideAction = {
            type = "NONE"
          }

          ruleActionOverrides = [
            {
              actionToUse = {
                allow = {}
              }
              name = "SizeRestrictions_Cookie_HEADER"
            },
            {
              actionToUse = {
                allow = {}
              }
              name = "SizeRestrictions_BODY"
            },
            {
              actionToUse = {
                allow = {}
              }
              name = "SizeRestrictions_URIPATH"
            },
            {
              actionToUse = {
                allow = {}
              }
              name = "SizeRestrictions_QUERYSTRING"
            },
          ]
          ruleGroupArn           = null
          ruleGroupType          = "ManagedRuleGroup"
          sampledRequestsEnabled = true
        },
        {
          excludeRules = []
          managedRuleGroupIdentifier = {
            vendorName           = "AWS"
            managedRuleGroupName = "AWSManagedRulesLinuxRuleSet"
          }
          overrideAction = {
            type = "NONE"
          }
          ruleGroupArn           = null
          ruleGroupType          = "ManagedRuleGroup"
          sampledRequestsEnabled = true
        },
        {
          excludeRules = []
          managedRuleGroupIdentifier = {
            vendorName           = "AWS"
            managedRuleGroupName = "AWSManagedRulesKnownBadInputsRuleSet"
          }
          overrideAction = {
            type = "NONE"
          }
          ruleGroupArn           = null
          ruleGroupType          = "ManagedRuleGroup"
          sampledRequestsEnabled = true
        },
      ]

      sampledRequestsEnabledForDefaultActions = true
      type                                    = "WAFV2"
    })
  }
}

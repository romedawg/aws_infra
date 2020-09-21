resource "pagerduty_service" "astronomer" {
  name                    = "astro-2"
  alert_creation          = "create_alerts_and_incidents"
  acknowledgement_timeout = "null"
  auto_resolve_timeout    = "null"
  description             = "Astronomer platform critical alerting"
  escalation_policy       = pagerduty_escalation_policy.shared_services_stack_escalation_policy.id
}

resource "pagerduty_service_integration" "astronomer_platform" {
  name                    = "Astronomer Platform"
  service                 = pagerduty_service.astronomer.id
  vendor                  = data.pagerduty_vendor.prometheus.id
}

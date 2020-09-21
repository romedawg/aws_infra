resource "pagerduty_escalation_policy" "shared_services_stack_escalation_policy" {
  name        = "Shared Services Stack Escalation Policy"
  num_loops   = 1
  description = ""

  teams = [pagerduty_team.engineering.id]


  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.shared_services_stack_schedule_v2.id
    }
  }
  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "user_reference"
      id   = module.rrafacz.id
    }
  }
}

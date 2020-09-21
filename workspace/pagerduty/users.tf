module "rrafacz" {
  source = "./users/rrafacz"
  teams  = [pagerduty_team.engineering.id]
}

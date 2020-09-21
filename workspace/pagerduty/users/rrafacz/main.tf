resource "pagerduty_user" "user" {
  name        = "Roman Rafacz"
  email       = "romanR32@gmail.com"
  role        = "limited_user"
  color       = "medium-violet-red"
  job_title   = ""
  description = ""
}

resource "pagerduty_team_membership" "team" {
  count   = length(var.teams)
  user_id = pagerduty_user.user.id
  team_id = var.teams[count.index]
}

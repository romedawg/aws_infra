/*
 *
 * VENDORS
 *
 */
data "pagerduty_vendor" "newrelic" {
  name = "New Relic"
}

data "pagerduty_vendor" "email" {
  name = "Email"
}

data "pagerduty_vendor" "splunk" {
  name = "Splunk"
}

data "pagerduty_vendor" "prometheus" {
  name = "Prometheus"
}

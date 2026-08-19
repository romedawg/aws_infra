terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

provider "newrelic" {
  api_key    = var.nr_admin_key
  account_id = var.newrelic_account_id
}

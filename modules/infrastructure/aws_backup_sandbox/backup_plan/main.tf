resource "aws_backup_plan" "main" {
  name = "tf_example_backup_plan"



  rule {
    rule_name         = "role_testing"
    target_vault_name = var.vault_name
    schedule          = "cron(0 12 * * ? *)"

    lifecycle {
      delete_after = 14
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "enabled"
    }
    resource_type = "EC2"
  }
}
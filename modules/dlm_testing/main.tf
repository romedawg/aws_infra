resource "aws_dlm_lifecycle_policy" "splunk_dlm_policy" {
  description        = "DLM lifecycle policy for hourly snapshots for Splunk data dir"
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "1 hour snapshots"

      fast_restore_rule {
        availability_zones = ["us-east-2a"]
        count              = 2
      }

      create_rule {
        interval      = 1
        interval_unit = "HOURS"
      }

      retain_rule {
        count = 2
      }

      tags_to_add = {
        SnapshotCreator = "DLM"
      }

      copy_tags = true

    }

    target_tags = {
      Name = "${var.environment}-splunk-data-dir"
    }
  }
}
resource "aws_s3_bucket" "s3_bucket" {
  bucket = local.s3_bucket_name

  tags = {
    name               = local.s3_bucket_name
    s3_bucket_name     = local.s3_bucket_name
    purpose            = "Bucket for backups"
    environment        = var.environment
    s3_backup_enabled  = true
    configuration_item = "${var.environment}_backup"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "storage" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "couchbase" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    id = "couchbase-backups"

    expiration {
      days = var.environment == "prod" ? 30 : 14
    }

    noncurrent_version_expiration {
      noncurrent_days = 1
    }

    filter {
      prefix = "couchbase/"
    }

    status = "Enabled"
  }
}

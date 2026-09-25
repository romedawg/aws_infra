resource "aws_s3_bucket" "astronomer_logs" {
  bucket        = "${local.name_prefix}-airflow-logs-${var.aws_account_id}"
  force_destroy = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-airflow-logs"
  })
}

resource "aws_s3_bucket_versioning" "astronomer_logs" {
  bucket = aws_s3_bucket.astronomer_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "astronomer_logs" {
  bucket = aws_s3_bucket.astronomer_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "astronomer_logs" {
  bucket = aws_s3_bucket.astronomer_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "astronomer_logs" {
  bucket = aws_s3_bucket.astronomer_logs.id

  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    filter {
      prefix = "logs/"
    }

    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket" "astronomer_dags" {
  bucket        = "${local.name_prefix}-airflow-dags-${var.aws_account_id}"
  force_destroy = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-airflow-dags"
  })
}

resource "aws_s3_bucket_versioning" "astronomer_dags" {
  bucket = aws_s3_bucket.astronomer_dags.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "astronomer_dags" {
  bucket = aws_s3_bucket.astronomer_dags.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "astronomer_dags" {
  bucket = aws_s3_bucket.astronomer_dags.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket" "storage" {
  bucket_prefix = "${var.bucket_prefix}-"

  tags = {
    name           = var.bucket_prefix
    s3_bucket_name = var.bucket_prefix
    purpose        = var.bucket_purpose
  }
}

resource "aws_s3_bucket_ownership_controls" "storage" {
  bucket = aws_s3_bucket.storage.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "storage" {
  depends_on = [aws_s3_bucket_ownership_controls.storage]

  bucket = aws_s3_bucket.storage.id
  acl    = var.acl
}

resource "aws_s3_bucket_versioning" "storage" {
  bucket = aws_s3_bucket.storage.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "storage" {
  bucket = aws_s3_bucket.storage.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

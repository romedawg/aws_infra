output "bucket_name" {
  description = "name of the s3 bucket"
  value       = aws_s3_bucket.storage.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.storage.arn
}

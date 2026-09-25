output "rds_endpoint" {
  description = "Astronomer RDS PostgreSQL endpoint"
  value       = aws_db_instance.astronomer.endpoint
}

output "rds_address" {
  description = "Astronomer RDS PostgreSQL hostname"
  value       = aws_db_instance.astronomer.address
}

output "db_credentials_secret_arn" {
  description = "ARN of the Secrets Manager secret containing DB credentials"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "logs_bucket_name" {
  description = "S3 bucket name for Airflow task logs"
  value       = aws_s3_bucket.astronomer_logs.bucket
}

output "dags_bucket_name" {
  description = "S3 bucket name for Airflow DAGs"
  value       = aws_s3_bucket.astronomer_dags.bucket
}

output "airflow_scheduler_role_arn" {
  description = "IRSA role ARN for Airflow scheduler"
  value       = aws_iam_role.airflow_scheduler.arn
}

output "airflow_worker_role_arn" {
  description = "IRSA role ARN for Airflow workers"
  value       = aws_iam_role.airflow_worker.arn
}

output "houston_role_arn" {
  description = "IRSA role ARN for Astronomer Houston API"
  value       = aws_iam_role.houston.arn
}

output "astronomer_namespace" {
  description = "Kubernetes namespace where Astronomer is deployed"
  value       = kubernetes_namespace.astronomer.metadata[0].name
}

output "helm_release_status" {
  description = "Status of the Astronomer Helm release"
  value       = helm_release.astronomer.status
}
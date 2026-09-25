output "astronomer_url" {
  description = "Astronomer platform URL"
  value       = "https://app.${module.astronomer.astronomer_namespace == "astronomer" ? "" : "${module.astronomer.astronomer_namespace}."}${local.base_domain}"
}

output "airflow_url" {
  description = "Airflow UI URL (Astronomer-managed deployments)"
  value       = "https://deployments.${local.base_domain}"
}

output "rds_endpoint" {
  description = "Astronomer RDS PostgreSQL endpoint"
  value       = module.astronomer.rds_endpoint
}

output "logs_bucket" {
  description = "S3 bucket for Airflow task logs"
  value       = module.astronomer.logs_bucket_name
}

output "dags_bucket" {
  description = "S3 bucket for Airflow DAGs"
  value       = module.astronomer.dags_bucket_name
}

output "db_credentials_secret_arn" {
  description = "Secrets Manager ARN for DB credentials"
  value       = module.astronomer.db_credentials_secret_arn
}

output "airflow_scheduler_role_arn" {
  description = "IRSA role for Airflow scheduler"
  value       = module.astronomer.airflow_scheduler_role_arn
}

output "airflow_worker_role_arn" {
  description = "IRSA role for Airflow workers"
  value       = module.astronomer.airflow_worker_role_arn
}

output "helm_release_status" {
  description = "Astronomer Helm release status"
  value       = module.astronomer.helm_release_status
}
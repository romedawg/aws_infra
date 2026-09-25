variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, staging, prod)"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_account_id" {
  type        = string
  description = "AWS account ID"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where EKS cluster and RDS will be deployed"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for RDS subnet group"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of the existing EKS cluster"
}

variable "eks_node_security_group_id" {
  type        = string
  description = "Security group ID attached to EKS worker nodes (for RDS ingress)"
}

variable "oidc_provider_arn" {
  type        = string
  description = "ARN of the EKS OIDC provider for IRSA"
}

variable "oidc_provider_url" {
  type        = string
  description = "URL of the EKS OIDC provider (without https://)"
}

variable "base_domain" {
  type        = string
  description = "Base domain for Astronomer (e.g. astronomer.internal.example.com)"
}

variable "astronomer_version" {
  type        = string
  description = "Astronomer Software Helm chart version"
  default     = "0.34.0"
}

variable "db_instance_class" {
  type        = string
  description = "RDS instance class for the Astronomer metadata database"
  default     = "db.t3.medium"
}

variable "db_allocated_storage" {
  type        = number
  description = "Allocated storage in GB for the Astronomer RDS instance"
  default     = 50
}

variable "db_max_allocated_storage" {
  type        = number
  description = "Max allocated storage in GB for RDS autoscaling"
  default     = 200
}

variable "db_name" {
  type        = string
  description = "Name of the Astronomer metadata database"
  default     = "astronomer"
}

variable "db_username" {
  type        = string
  description = "Master username for the Astronomer RDS instance"
  default     = "astronomer"
}

variable "db_deletion_protection" {
  type        = bool
  description = "Enable deletion protection on RDS"
  default     = true
}

variable "db_backup_retention_days" {
  type        = number
  description = "Number of days to retain automated RDS backups"
  default     = 7
}

variable "astronomer_namespace" {
  type        = string
  description = "Kubernetes namespace for Astronomer"
  default     = "astronomer"
}

variable "admin_email" {
  type        = string
  description = "Email for the Astronomer platform admin user"
}

variable "smtp_enabled" {
  type        = bool
  description = "Enable SMTP for Astronomer email notifications"
  default     = false
}

variable "smtp_host" {
  type        = string
  description = "SMTP host for email notifications"
  default     = ""
}

variable "smtp_port" {
  type        = number
  description = "SMTP port"
  default     = 587
}

variable "smtp_username" {
  type        = string
  description = "SMTP username"
  default     = ""
  sensitive   = true
}

variable "smtp_password" {
  type        = string
  description = "SMTP password"
  default     = ""
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources"
  default     = {}
}

variable "postgres_version" {}

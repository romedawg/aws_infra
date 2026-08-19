variable "environment" {
  description = "the environment the application will be running in"
}

variable "kms_cross_account_principals" {
  description = "List of external AWS account IDs granted KMS decrypt/encrypt access (e.g. Zscaler scanning)"
  type        = list(string)
  default     = []
}
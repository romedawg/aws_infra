variable "account_id" {}

variable "type" {
  type        = string
  description = "Type of terraform state. Base type is meant to be used for base infrastructure, e.g. network components. Vendor type is managed by the vendor."

  validation {
    condition     = contains(["base", "vendor"], var.type)
    error_message = "Valid values for type variable are (base, vendor)."
  }
}
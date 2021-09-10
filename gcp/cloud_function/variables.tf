terraform {
  experiments = [module_variable_optional_attrs]
}

variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "app_meta" {
  description = "Application metadata"
  type        = object({
    product = string
    env     = string
    app     = string
  })
}

variable "labels" {
  description = "Resource labels"
  type        = map(string)
}

variable "env_vars" {
  description = "Environment variables"
  type        = map(string)
}

variable "vpc_connector_id" {
  description = "VPC connector id"
  default     = null
  type        = string
}

variable "service_account_email" {
  description = "Service account email"
  type = string
}

variable "func_params" {
  description = "Cloud function params"
  type = any
}

variable "schedulers" {
  description = "Cloud schedulers"
  default     = []
  type        = list(object({
    name        = string
    schedule    = string
    time_zone   = optional(string)
    timeout     = optional(number)
    uri_path    = optional(string)
    http_method = string
    body        = optional(string)
    retry_count = optional(number)
  }))
}

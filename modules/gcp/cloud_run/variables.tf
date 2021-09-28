terraform {
  experiments = [module_variable_optional_attrs]
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

variable "vpc_connection_name" {
  description = "VPC connection name"
  default     = null
  type        = string
}

variable "service_account_email" {
  description = "Service account email"
  type        = string
}

variable "run_params" {
  description = "Cloud run params"
  type        = object({
    name          = string
    image_uri     = string
    cpu           = string
    memory        = string
    timeout       = number
    min_scale     = optional(number)
    max_scale     = optional(number)
    cpu_throttling = optional(bool)
    container_concurrency = optional(number)
    public_access = optional(bool)
  })
}

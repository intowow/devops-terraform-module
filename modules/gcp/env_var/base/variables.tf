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

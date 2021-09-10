variable "app_meta" {
  description = "Application metadata"
  type        = object({
    product = string
    env     = string
    app     = string
  })
}

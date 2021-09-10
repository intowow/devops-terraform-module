variable "app_meta" {
  description = "Application metadata"
  type        = object({
    product = string
    env     = string
    app     = string
  })
}

variable "additional_labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}

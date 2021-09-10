output "vars" {
  description = "Environment vars for mysql connection"
  value       = {
    PRODUCT = var.app_meta.product
    ENV     = var.app_meta.env
    APP     = var.app_meta.app
  }
}

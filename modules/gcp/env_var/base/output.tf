output "vars" {
  description = "Environment vars for mysql connection"
  value       = {
    CLOUD_PLATFORM = "gcp"
    GCP_PROJECT_ID = var.project_id
    PRODUCT        = var.app_meta.product
    ENV            = var.app_meta.env
    APP            = var.app_meta.app
  }
}

output "vars" {
  description = "Environment vars for google oauth info"
  value       = {
    GOOGLE_SECRET_ID = var.secret_id
  }
}

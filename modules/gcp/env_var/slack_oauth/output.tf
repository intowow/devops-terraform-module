output "vars" {
  description = "Environment vars for slack oauth info"
  value       = {
    SLACK_SECRET_ID = var.secret_id
  }
}

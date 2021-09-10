output "username" {
  description = "Mysql username"
  value       = google_sql_user.mysql_user.name
}

output "secret" {
  description = "Secret contains mysql user username/password"
  value       = {
    id              = google_secret_manager_secret.mysql.id
    current_version = google_secret_manager_secret_version.mysql_secret_version.id
    latest_version  = "${google_secret_manager_secret.mysql.id}/versions/latest"
  }
}

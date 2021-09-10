output "vars" {
  description = "Environment vars for mysql connection"
  value       = {
    MYSQL_HOST        = var.host
    MYSQL_PORT        = var.port
    MYSQL_SOCKET_PATH = var.socket_path
    MYSQL_SECRET_ID   = var.secret_id
    MYSQL_DATABASE    = var.database
  }
}

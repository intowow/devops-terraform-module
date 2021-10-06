output "vars" {
  description = "Environment vars for redis connection"
  value       = {
    REDIS_HOST = var.host
    REDIS_PORT = var.port
  }
}

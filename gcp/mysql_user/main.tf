resource "random_password" "mysql_user_password" {
  length  = 16
  lower   = true
  upper   = true
  number  = true
  special = false
  keepers = {
    user    = var.username
    version = "2"
  }
}

resource "google_sql_user" "mysql_user" {
  name     = var.username
  password = random_password.mysql_user_password.result
  host     = "%"
  instance = var.mysql_instance
}

# Secrets
resource "google_secret_manager_secret" "mysql" {
  secret_id = "${var.app_meta.product}_${var.app_meta.env}_${var.app_meta.app}_mysql-secret"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "mysql_secret_version" {
  secret = google_secret_manager_secret.mysql.id
  secret_data = jsonencode({
    user     = google_sql_user.mysql_user.name
    password = google_sql_user.mysql_user.password
  })
  enabled = true
}
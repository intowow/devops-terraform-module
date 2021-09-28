resource "google_cloud_run_service" "cr" {
  name     = (var.run_params.name == var.app_meta.app) ? var.run_params.name : "${var.app_meta.app}_${var.run_params.name}"
  location = "asia-northeast1"

  template {
    spec {
      service_account_name = var.service_account_email
      container_concurrency = var.run_params.container_concurrency
      timeout_seconds       = var.run_params.timeout

      containers {
        image = var.run_params.image_uri

        resources {
          limits = {
            cpu    = var.run_params.cpu
            memory = var.run_params.memory
          }
        }

        dynamic "env" {
          for_each = var.env_vars
          content {
            name  = env.key
            value = env.value
          }
        }
      }
    }

    metadata {
      labels      = var.labels
      annotations = {
        "autoscaling.knative.dev/minScale"        = var.run_params.min_scale
        "autoscaling.knative.dev/maxScale"        = var.run_params.max_scale
        "run.googleapis.com/cloudsql-instances"   = var.vpc_connection_name
        "run.googleapis.com/client-name"          = var.app_meta.app
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector_id
        "run.googleapis.com/cpu-throttling"       = var.run_params.cpu_throttling != null ? var.run_params.cpu_throttling : true
      }
    }
  }
  autogenerate_revision_name = true
}

data "google_iam_policy" "noauth" {
  count = var.run_params.public_access != null ? (var.run_params.public_access ? 1 : 0) : 0
  binding {
    role    = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  count    = var.run_params.public_access != null ? (var.run_params.public_access ? 1 : 0) : 0
  location = google_cloud_run_service.cr.location
  project  = google_cloud_run_service.cr.project
  service  = google_cloud_run_service.cr.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

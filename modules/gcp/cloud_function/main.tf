resource "google_cloudfunctions_function" "cfn" {
  name                  = (var.func_params.name == var.app_meta.app) ? var.func_params.name : "${var.app_meta.app}_${var.func_params.name}"
  entry_point           = var.func_params.entrypoint
  available_memory_mb   = var.func_params.memory
  timeout               = var.func_params.timeout
  runtime               = var.func_params.runtime
  trigger_http          = var.func_params.http_trigger
  labels                = var.labels
  source_archive_bucket = var.func_params.bucket
  source_archive_object = var.func_params.object
  service_account_email = var.service_account_email
  vpc_connector         = var.vpc_connector_id
  environment_variables = var.env_vars
}

resource "google_cloudfunctions_function_iam_binding" "for_everyone" {
  count          = var.func_params.public_access != null ? (var.func_params.public_access ? 1 : 0) : 0
  cloud_function = google_cloudfunctions_function.cfn.name
  role           = "roles/cloudfunctions.invoker"
  members = [
    "allUsers"
  ]
}

resource "google_cloud_scheduler_job" "job" {
  for_each         = var.func_params.http_trigger ? { for s in var.func_params.schedulers: s.name => s } : {}

  name             = "${var.app_meta.app}_${each.value.name}"
  description      = "${var.app_meta.app}_${each.value.name}"
  schedule         = each.value.schedule
  time_zone        = coalesce(each.value.time_zone, "Etc/UTC")
  attempt_deadline = each.value.timeout != null ? "${each.value.timeout}s" : "${var.func_params.timeout}s"

  retry_config {
    retry_count = coalesce(each.value.retry_count, 1)
  }

  http_target {
    http_method = each.value.http_method
    uri         = each.value.uri_path != null ? "${google_cloudfunctions_function.cfn.https_trigger_url}/${each.value.uri_path}" : google_cloudfunctions_function.cfn.https_trigger_url
    body        = each.value.body

    oidc_token {
      service_account_email = var.service_account_email
    }

  }
}

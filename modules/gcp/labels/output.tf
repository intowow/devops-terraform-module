output "labels" {
  description = "GCP resources labels"
  value       = merge(
    var.app_meta,
    var.additional_labels
  )
}

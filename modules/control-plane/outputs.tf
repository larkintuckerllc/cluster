output "cluster_ca_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the cluster endpoint."
  value       = google_container_cluster.default.master_auth[0].cluster_ca_certificate
}

output "endpoint" {
  description = "The IP address of this cluster's Kubernetes master."
  value       = google_container_cluster.default.endpoint
}

output "google_service_account_email" {
  description = "The Google service account email address."
  value       = google_service_account.default.email
}

output "location" {
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well."
  value       = google_container_cluster.default.location
}

output "name" {
  description = "The name of the cluster, unique within the project and location."
  value       = google_container_cluster.default.name
}

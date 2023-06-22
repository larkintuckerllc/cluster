terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.68.0"
    }
  }
}

resource "google_container_node_pool" "default" {
  name     = var.name
  cluster  = var.cluster
  location = var.location
  management {
    auto_upgrade = true
  }
  node_count = 1
  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    service_account = var.service_account
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }
}

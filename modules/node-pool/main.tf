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
    auto_repair  = true # FORCED TO ADD AS DEFAULTS TO FALSE
    auto_upgrade = var.node_pool_auto_upgrade
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
  version = var.node_pool_auto_upgrade ? null : var.blue ? var.blue_version : var.green_version
}

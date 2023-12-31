terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.68.0"
    }
  }
}

data "google_client_config" "default" {}

resource "google_service_account" "default" {
  account_id   = var.name
  display_name = var.name
}

resource "google_project_iam_member" "default" {
  project = data.google_client_config.default.project
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${google_service_account.default.email}"
}

resource "google_container_cluster" "default" {
  name              = var.name
  datapath_provider = "ADVANCED_DATAPATH"
  dns_config {
    cluster_dns        = "CLOUD_DNS"
    cluster_dns_domain = var.name
    cluster_dns_scope  = "VPC_SCOPE"
  }
  initial_node_count = 1
  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }
  location = var.location

  dynamic "maintenance_policy" { # RELEASE_CHANNEL UNSPECIFIED NO SUPPORT FOR MAINTENANCE_POLICY
    for_each = var.auto_upgrade ? list(true) : []
    content {
      daily_maintenance_window {
        start_time = "00:00" # DEFAULT 4 HOUR WINDOW
      }
      maintenance_exclusion {
        exclusion_name = "Prevent Upgrades"
        start_time     = var.maintenance_exclusion_start_time
        end_time       = var.maintenance_exclusion_end_time
        exclusion_options {
          scope = "NO_MINOR_UPGRADES"
        }
      }
    }
  }
  min_master_version = var.min_master_version
  network            = "default"
  release_channel {
    channel = var.auto_upgrade ? "STABLE" : "UNSPECIFIED"
  }
  remove_default_node_pool = true
  subnetwork               = var.subnetwork
  workload_identity_config {
    workload_pool = "${data.google_client_config.default.project}.svc.id.goog"
  }
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

locals {
  blue_version                     = "1.25.8-gke.500"       # ONLY USED IF NODE_POOL_AUTO_UPGRADE IS FALSE
  green_version                    = "1.25.8-gke.500"       # ONLY USED IF NODE_POOL_AUTO_UPGRADE IS FALSE
  maintenance_exclusion_end_time   = "2023-10-01T00:00:00Z" # NO MORE THAN 180 DAYS
  maintenance_exclusion_start_time = "2023-06-01T00:00:00Z"
  min_master_version               = "1.25.8-gke.500"
}

data "google_client_config" "default" {}

module "control_plane" {
  source                           = "./modules/control-plane"
  auto_upgrade                     = var.auto_upgrade
  cluster_secondary_range_name     = var.cluster_secondary_range_name
  maintenance_exclusion_end_time   = local.maintenance_exclusion_end_time
  maintenance_exclusion_start_time = local.maintenance_exclusion_start_time
  min_master_version               = local.min_master_version
  location                         = var.location
  name                             = var.name
  services_secondary_range_name    = var.services_secondary_range_name
  subnetwork                       = var.subnetwork
}

module "node_pool" {
  for_each        = var.node_pool
  source          = "./modules/node-pool"
  auto_upgrade    = var.auto_upgrade
  blue            = each.value["blue"]
  blue_version    = local.blue_version
  cluster         = var.name
  green_version   = local.green_version
  location        = var.location
  machine_type    = each.value["machine_type"]
  name            = each.key
  service_account = module.control_plane.google_service_account_email
}

provider "kubectl" {
  cluster_ca_certificate = base64decode(module.control_plane.cluster_ca_certificate)
  host                   = "https://${module.control_plane.endpoint}"
  load_config_file       = false
  token                  = data.google_client_config.default.access_token
}

module "config_sync" {
  source     = "./modules/config-sync"
  depends_on = [module.node_pool]
}

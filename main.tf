terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

data "google_client_config" "default" {}

module "control_plane" {
  source                        = "./modules/control-plane"
  cluster_secondary_range_name  = var.cluster_secondary_range_name
  location                      = var.location
  name                          = var.name
  services_secondary_range_name = var.services_secondary_range_name
  subnetwork                    = var.subnetwork
}

module "node_pool" {
  for_each        = var.node_pool
  source          = "./modules/node-pool"
  cluster         = var.name
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

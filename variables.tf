variable "cluster_secondary_range_name" {
  description = "The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses. Alternatively, cluster_ipv4_cidr_block can be used to automatically create a GKE-managed one."
  type        = string
}

variable "location" {
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well."
  type        = string
}

variable "name" {
  description = "The name of the cluster, unique within the project and location."
  type        = string
}

variable "node_pool" {
  description = "The node pools"
  type = map(object({
    machine_type : string
  }))
}

variable "services_secondary_range_name" {
  description = "The name of the existing secondary range in the cluster's subnetwork to use for service ClusterIPs. Alternatively, services_ipv4_cidr_block can be used to automatically create a GKE-managed one."
  type        = string
}

variable "subnetwork" {
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
  type        = string
}


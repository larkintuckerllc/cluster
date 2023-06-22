variable "cluster_secondary_range_name" {
  description = "The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses. Alternatively, cluster_ipv4_cidr_block can be used to automatically create a GKE-managed one."
  type        = string
}

variable "location" {
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well."
  type        = string
}

variable "maintenance_exclusion_end_time" {
  description = "Exceptions to maintenance window. Non-emergency maintenance should not occur in these windows."
  type        = string
}

variable "maintenance_exclusion_start_time" {
  description = "Exceptions to maintenance window. Non-emergency maintenance should not occur in these windows."
  type        = string
}

variable "min_master_version" {
  description = "The minimum version of the master. GKE will auto-update the master to new versions, so this does not guarantee the current master version--use the read-only master_version field to obtain that. If unset, the cluster's version will be set by GKE to the version of the most recent official release (which is not necessarily the latest version)."
  type        = string
}

variable "name" {
  description = "The name of the cluster, unique within the project and location."
  type        = string
}

variable "node_pool_auto_upgrade" {
  description = "Whether the nodes will be automatically upgraded."
  type        = bool
}

variable "release_channel" {
  description = "Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters. Note that removing this field from your config will not unenroll it. Instead, use the UNSPECIFIED channel."
  type        = string
}

variable "services_secondary_range_name" {
  description = "The name of the existing secondary range in the cluster's subnetwork to use for service ClusterIPs. Alternatively, services_ipv4_cidr_block can be used to automatically create a GKE-managed one."
  type        = string
}

variable "subnetwork" {
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
  type        = string
}

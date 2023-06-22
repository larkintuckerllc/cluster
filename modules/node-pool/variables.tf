variable "cluster" {
  description = "The cluster to create the node pool for. Cluster must be present in location provided for zonal clusters."
  type        = string
}

variable "location" {
  description = "The location (region or zone) of the cluster."
  type        = string
}

variable "machine_type" {
  description = "The name of a Google Compute Engine machine type."
  type        = string
}

variable "name" {
  description = "The name of the node pool. If left blank, Terraform will auto-generate a unique name."
  type        = string
}

variable "node_pool_auto_upgrade" {
  description = "Whether the nodes will be automatically upgraded."
  type        = bool
}

variable "node_pool_version" {
  description = "The Kubernetes version for the nodes in this pool. Note that if this field and auto_upgrade are both specified, they will fight each other for what the node version should be, so setting both is highly discouraged. While a fuzzy version can be specified, it's recommended that you specify explicit versions as Terraform will see spurious diffs when fuzzy versions are used. See the google_container_engine_versions data source's version_prefix field to approximate fuzzy versions in a Terraform-compatible way."
  type        = bool
}

variable "service_account" {
  description = "The Google Cloud Platform Service Account to be used by the node VMs."
  type        = string
}

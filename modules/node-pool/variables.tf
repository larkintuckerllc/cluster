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

variable "service_account" {
  description = "The Google Cloud Platform Service Account to be used by the node VMs."
  type        = string
}

data "google_secret_manager_secret_version" "default" {
  secret = "operator-owned-gke-cluster"
}

locals {
  github_ssh_public_key = base64encode(data.google_secret_manager_secret_version.default.secret_data)
}

resource "kubectl_manifest" "config_sync_config_secret" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: git-creds
  namespace: config-management-system
type: Opaque
data:
  ssh: ${local.github_ssh_public_key}
YAML
}

resource "time_sleep" "config_management_operator_deployment" {
  create_duration = "60s"
  depends_on = [
    kubectl_manifest.config_management_operator_deployment
  ]
}

resource "kubectl_manifest" "config_sync_config_configmanagement" {
  depends_on = [
    kubectl_manifest.config_management_operator_crd,
    time_sleep.config_management_operator_deployment
  ]
  yaml_body = <<YAML
apiVersion: configmanagement.gke.io/v1
kind: ConfigManagement
metadata:
  name: config-management
spec:
  enableMultiRepo: true
YAML
}

resource "time_sleep" "config_sync_config_configmanagement" {
  create_duration = "60s"
  depends_on = [
    kubectl_manifest.config_sync_config_configmanagement
  ]
}

resource "kubectl_manifest" "config_sync_config_rootsync" {
  depends_on = [
    kubectl_manifest.config_sync_config_secret,
    time_sleep.config_sync_config_configmanagement
  ]
  yaml_body = <<YAML
apiVersion: configsync.gke.io/v1beta1
kind: RootSync
metadata:
  name: operator-owned-gke-cluster
  namespace: config-management-system
spec:
  sourceType: git
  sourceFormat: unstructured
  git:
    repo: git@github.com:larkintuckerllc/operator-owned-gke-cluster
    branch: main
    auth: ssh
    secretRef:
      name: git-creds
YAML
}

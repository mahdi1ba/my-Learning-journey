# variables.tf

variable "resource_group_location" {
    default = "eastus"
    description = "Location of the resource group."
  
}

variable "agent_count" {
    default = 3
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
  
}

variable "dns_prefix" {
    default = "k8sguru"
  
}

variable "cluster_name" {
    default = "k8sguru"
  
}

variable "location" {
    default = "eastus"

  
}

variable "log_analytics_workspace_name" {
    default = "guruLogAnlyticsWorkspaceName"
  
}

variable "log_analytics_workspace_location" {
    default = "eastus"
  
}

variable "log_analytics_workspace_sku" {
    default = "...."
  
}
variable "aks_service_principal_app_id" {
    default = "......."
  
}

variable "aks_service_principal_client_secret" {
  default = "..."
}

variable "aks_service_principal_object_id" {
  default = "..."
}

#output.tf

output "resource_group_name" {
    value = azurerm_resource_group.k8s.name
  
}

output "client_key" {
    value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_key
  
}

output "client_certificate" {
    value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate

  
}

output "cluster_ca_certificate" {
    value = azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate

}

output "cluster_username" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.o.username
}
output "cluster_password" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.o.password
}
output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}
output "host" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.o.host
}
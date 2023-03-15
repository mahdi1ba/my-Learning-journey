# random ID for log analytics:

resource "random_id" "log_analytics" {
    byte_length = 8
  
}

# log analytics workspace:

resource "azurerm_log_analytics_workspace" "k8s" {
    name = "${var.log_analytics_workspace_name}-${random_id.log_analytics.dec}"
    location = var.log_analytics_workspace_location
    resource_group_name = azurerm_resource_group.k8s.name
    sku = var.log_analytics_workspace_sku
}

#log analytics solution:

resource "azurerm_log_analytics_solution" "k8s" {
    solution_name = "ContainerInsights"
    resource_group_name = azurerm_resource_group.k8s.name
    location = azurerm_log_analytics_workspace.k8s.location
    workspace_resource_id = azurerm_log_analytics_workspace.k8s.id
    workspace_name = azurerm_log_analytics_workspace.k8s.name
    plan = {
        publisher = "Microsoft"
        product = "OMSGallery/ContainerInsights"
    }
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name = var.cluster_name
    resource_group_name = azurerm_resource_group.k8s.name
    location = azurerm_log_analytics_workspace.k8s.location
    dns_prefix = var.dns_prefix
    linux_profile {
      admin_username = "ubuntu"

      ssh_key {
          key_data = file(var.ssh_public_key)
      }
    }
    default_node_pool = {
        name = "agentpool"
        node_count = var.agent_count
        vm_size = "standard_D2s_v3"
      
    }

    service_principal {
      client_id = var.aks_service_principal_app_id
      client_secret = var.aks_service_principal_client_secret
    }

    addon_profile {
        oms_agent{
            enable = true
            log_analytics_workspace_id = azurerm_log_analytics_workspace.k8s.id
        }
    }
    network_profile {
      load_balancer_sku = "Standard"
      network_plugin = "kubenet"
    }
    tags {
        Environement = "staging"
    }
  
}
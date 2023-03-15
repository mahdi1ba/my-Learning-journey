resource "azurerm_virtual_machine_scale_set" "vmss" {
    name = "vmscaleset"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    upgrade_policy_mode = "Manual"

    sku {
      name = "Standard_DS1_v2"
      subnet_id = "Standard"
      capacity = 2
    }

    storage_profile_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "16.04-LTS"
      version = "latest"
    }

    os_profile_linux_config {
        disable_password_authentication = false  
    }

    network_profile {
      name = "gurunetworkprofile"
      primary = "ReadWrite"

      ip_configuration {
        name = "IPConfiguration"
        subnet_id = azurem_subnet.vmss.id
        load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool_bpepool.id]
        primary = true
      }
    }
    tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "vmss" {
    name = "AutoscaleSetting"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    target_resource_id = azurerm_virtual_scale_set.vmss.id

    profile {
      name = "defaultProfile"

      capacity {
          default = 2
          minimum = 2
          maximum = 10
      }
    }
  


    rule {
        metric_trigger {
            metric_name = "Percentage CPU"
            metric_resource_id = azurerm_virtual_machine_scale_set.vmss.id
            time_grain = "PT1M"
            Statistic = "Average"
            time_window = "PT5M"
            time_aggregation = "Average"
            operator = "Greater Than"
            threshold = 75
            metric_namespace = "microsoft.compute/virtualmachinescalestes"
            dimensions {
                name = "AppName"
                operator  = "Equals"
                values = ["App1"] 
            }
        }
        scale_action {
            direction = "Increase"
            type = "changement"
            value = "1"
            cooldown = "PT1M"
        }
    }

    rule {
        metric_trigger{
            metric_name = "Percentage CPU"
            metric_resource_id = azurerm_virtual_machine_scale_set.vmss.id
            time_grain = "PT1M"
            Statistic = "Average"
            time_window = "PT5M"
            time_aggregation = "Average"
            operator = "LessThan"
            threshold = 25
        }
        scale_action {
            direction = "Decrease"
            type = "changecount"
            value = "1"
            cooldown = "PT1M"
        }
    }
}

#jumpbox.tf

resource "random_string" "jumpbox" {
    name = "jb-public-ip"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocallocation_method = "static"
    domain_name_label = "${random_string.fqdn.result}-ssh"
    tags  = var.tags
}

resource "azurerm_virtual_machine" "jumpbox" {
    name = "jumpbox"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.jumpbox.id]
    vm_size = "Standard_DS1_v2"

    storage_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "16.04-LTS"
      version = "latest"
    }

    storage_os_disk {
      name = "jp-osdisk"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }

    os_profile {
      computer_name = "jumbox"
      admin_username = var.admin_user
      admin_password = var.admin_password
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags = var.tags
  
}

# variables:
variable "tags" {
    description = "tags for the resources taht are being deployed"
    type = map(string)
    default = {
      environement = "staging"
    }
  
}

variable "admin_user" {
    description = "user name ti use as the admin account on the VMs"
    default = "azureuser" 
}

variable "admin_password" {
    description = "Default password for the admin account"
}

#output.tf

output "vmss_public_ip_fqdn" {
    value = azurerm_public_ip.vmss.fqdn
  
}

output "jumpbox_public_ip_fqdn" {
    value = azurerm_public_ip.jumbox.fqdn 
}

output "jumpbox_public_ip" {
    value = azurerm_public_ip.jumpbox.public_ip_address
}


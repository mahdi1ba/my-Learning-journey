resource "azurerm_linux_virtual_machine" "vm" {
    name = "guruVM"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.nic.id]
    size = "Standard_DS1_v2"

    os_disk {
      name = "OsDisk"
      subnet_id  = "ReadWrite"
      private_ip_address_allocation = "Premium_LRS"
    }

    source_image_reference {
      
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "18.04-LTS"
      version = "latest"
        
    }
    computer_name = "guruVM"
    admin_username = "azureuser"
    disable_password_authentication = true
    admin_ssh_key {
        username = "OsDisk"
        public_key = tls_private_key.ssh.public_key_openssh
    }

    boot_diagnostics {
      storage_account_uri = azurerm_storage_account.storageaccount.primary_blob_endpoint
    }
}
resource "tls_private_key" "ssh" {
    algorithm = "RSA"
    rsa_bits = 4096
}

variable "resource_group_name_prefix" {
    default = "rg"
    description = "Added to the random ID to give it a unique name."
  
}

variable "resource_group_location" {
    default = "eastus"
    description = "Location of the resource group"  
}

variable "resource_group_name" {
    default = "<RESOURCE_GROUP_NAME_PLACEHOLDER>"
    description = "prefix of the reosurce group name that's combined with random ID so name is unqiue in your Azure subscription."  
}
output "resource_group_name" {
    value = azurerm_resource_group.rg.name
}

output "public_ip_address" {
    value = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "tls_private_key" {
    value = tls_private_key.ssh.private_key_pem
    sensitive = true
}

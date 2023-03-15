# This section assigns teh .id value of the azurerm_subnet.tfsubnet call during the up_configuration section.
data "azurerm_subnet" "tfsubnet" {
    name = "mySubnet"
    virtual_network_name = "myVnet"
    resource_group_name = "TFResourceGroup"
}
# Creates a public IP address taht can be added to the VM NIC with manual entries for the name, location, and resource group
resource "azurerm_public_ip" "exemple" {
    name = "pubip1"
    location = "East US"
    resource_group_name = "TFResourceGroup"
    allocallocation_method = "Dynamic"
    sku = "Basic" 
  
}
# this section creates the NIC itself
resource "azurerm_network_interface" "exemple" {
    name = "forge-nic" #var.nic_id
    location = "East US"
    resource_group_name = "TFResourceGroup"
    # this section sets the IP info for the NIC being created. note the subnet_id value is calling the name set by the data assignment set at the beginning.
    ip_configuration {
        name = "ipconfig1"
        subnet_id = azurerm_subnet.tfsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.exemple.id
    }
}
# this section creates the boot diagnostic storage account for the VM .
resource "azurerm_storage_account" "sa" {
    name = "forgebootdiags123" #var.bdiag
    resource_group_name = "TFResourceGroup"
    location = "East US"
    account_tier = "standard"
    account_replication_type = "LRS"
}

resource "azurerm_virtual_machine" "exemple" {
    name = "forge" #var.servername
    location = "East US"
    resource_group_name = "TFResourceGroup"
    network_interface_ids = [ azurerm_network_interface.exemple.id]
    vm_size = "Standard_B1s"
    delete_os_disk_on_termination = true
    delete_data_disks_on_termination = false
    storage_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "16.04-LTS"
      version = "latest"
    }
    storage_os_disk {
      name = "osdisk1"
      disk_size_gb = "128"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
    os_profile{
        computer_name = "forge"
        admin_username = "vmadmin"
        admin_password = "Password12345!"
    }
    os_profile_linux_config {
      disable_password_authentification = false
    }
    boot_diagnostics {
      enabled = "true"
      storage_uri = azurerm_storage_account.sa.primary_blob_endpoint
    }
}
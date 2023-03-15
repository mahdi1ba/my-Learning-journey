resource "azurerm_lb" "comics" {
    name = "loadBalancer"
    resource_group_name = azurerm_resource_group.comics.name
    location = azurerm_resource_group.comics.location

    frontend_ip_configuration {
        name = "publicIPAddress"
        public_ip_address_id = azurerm_public_ip.comics.id
    }
}

resource "azurerm_lb_backend_address_pool" "comics" {
    loadbalancer_id = azurerm_lb.comics.id
    name = "BackEndAddressPool"
}

resource "azurerm_network_interface" "comics" {
    count = 2
    name = "nic${count.index}"
    location = azurerm_resource_group.comics.location
    resource_group_name = azurerm_resource_group.comics.name

    ip_configuration {
        name = "comicsConfiguration"
        subnet_id = azurerm_subnet.comics.id
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_managed_disk" "comics" {
    count = 2
    name = "datadisk_existing_${count.index}"
    location = azurerm_resource_group.comics.location
    resource_group_name = azurerm_resource_group.comics.name
    storage_account_type = "standard_LRS"
    create_option = "Empty"
    disk_size_gb = "1023"
  
}

resource "azurerm_availability_set" "comics" {
    name = "avset"
    location = azurerm_resource_group.comics.location
    resource_group_name = azurerm_resource_group.comics.name
    platform_fault_domain_count = 2
    platform_update_domain_count = 2
    managed = true
}

resource "azurerm_virtual_machine" "comics" {
    count = 2
    name = "vm${count.index}"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    availability_set_id = azurerm_availability_set.avset.id
    network_interface_ids = [element(azurerm_network_interface.nic.*.id,count.index)]
    vm_size = "Standard_DS1_v2"

    # delete_os_disk_on_termination = true
    # delete_data_disks_on_termination = true

    source_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "18.04-LTS"
        version = "latest"
    }
    storage_os_disk {
        name = "osdisk${count.index}"
        caching = "ReadWrite"
        create_option = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_data_disk {
        name = element(azurerm_managed_disk.disks.*.name, count.index)
        managed_disk_type = element(azurerm_managed_disk.disks.*.id ,count.index)
        create_option = "Attach"
        lun = 1
        disk_size_gb = element(azurerm_managed_disk.disks.*.disk_size_gb, count.index)
    }

    os_profile {
        computer_name = "hostname"
        admin_username = "testadmin"
        admin_password = "Password1234"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags = {
      environement = "staging"
    }
  
}
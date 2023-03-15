resource "azurerm_virtual_machine" "vm" {
    count = 2
    name = "guruVM"
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

resource "azurerm_availability_set" "avset" {
    name = "guru_avset"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    platform_fault_domain_count = 2
    platform_update_domain_count = 2
    managed = true
}
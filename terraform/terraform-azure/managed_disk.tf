resource "azurerm_managed_disk" "disks" {
    count = 2
    name = "datadisk_existing_${count.index}"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    storage_account_type = "Standard_LRS"
    create_option = "Empty"
    disk_size_gb  = "1"
}


variable "resgrp" {
    description = "Copy and paste the resource group name from the portal"
}

variable "storageaccount" {
    description = "Enter a unique name for the storage account that will be used for the file share"
}

variable "container" {
    description = "Enter container name"
}

resource "azurerm_storage_account" "new" {
    name = var.storageaccount
    resource_group_name = var.resgrp
    location = "eastus"
    account_tier = "Standard"
    account_replication_type = "LRS"
  
}

resource "azurerm_storage_container" "new" {
    name = var.container
    storage_account_name = var.storageaccount
    container_access_type = "private"
  
}

resource "azurerm_storage_blob" "new" {
    name = "newTFblob"
    resource_group_name = var.resgrp
    storage_container_name = var.container
    type = "Block"
  
}
resource "azurerm_storage_account" "new" {
    name = "awesomestorageaccount"
    resource_group_name = "resourcegroupforstorage"
    location = "eastus"
    account_tier = "Standard"
    account_replication_type = "LRS"
  
}

resource "azurerm_storage_share" "exemple" {
    name = "awesomeshare"
    storage_account_name = azurerm_storage_account.exemple.name
    quota = 50
  
}
variable "region" {}
variable "ResourceGroup" {}
variable "Storage_Account_Name" {}

resource "azurerm_storage_account" "sa" {
    name = var.Storage_Account_Name
    resource_group_name = var.ResourceGroup
    location = var.region
    account_tier = "Standard"
    account_replication_type = "GRS"

    tags = {
        environement = "Terraform Storage"
        CreatedBy = "TF Admin"
    }
  
}

resource "azurerm_storage_account" "sa" {
    name = "Storage Account Name"
    resource_group_name = "Resource Group"
    location = "Location/Region"
    account_tier = "Standard"
    account_replication_type = "GRS"

    tags = {
        environement = "Terraform Storage"
        CreatedBy = "TF Admin"
    }
  
}


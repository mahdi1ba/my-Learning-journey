provider "azurerm" {
    version = 1.38
}

resource "azurerm_storage_account" "lab" {
    name = ""
    resource_group_name = ""
    location = ""
    access_tier = ""
    account_replication_type = ""

    tags = {
      environement = "value"
      CreatedBy = "Admin"
    }
  
}
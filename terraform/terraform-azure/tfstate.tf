resource "azurerm_resource_group" "tfstate" {
    name = "tfstate"
    location = "eastus"
  
}

resource "random_string" "tfstate" {
    length = 5
    special = false
    upper = false
}

resource "azurerm_storage_account" "tfstate" {
    name = "tfstate${random_string.resource_code.result}"
    resource_group_name = azurerm_resource_group.tfstate.name
    location = azurerm_resource_group.tfstate.location
    access_tier = "Standard"
    account_replication_type = "LRS"
    allow_blob_public_access = true

    tags = {
      environement = "dev"
    }
}

resource "azurerm_storage_container" "tfstate" {
    name = "tfsate"
    storage_account_name = azurerm_storage_account.tfstate.name
    container_access_type = "blob"
  
}

terraform{
    required_providers{
        azurerm = {
            source = "hashicorp/azurerm"
            version = "2.46.0"
        }
    }
    backend "azurerm" {
        resource_group_name = "tfstate"
        storage_account_name = "<STORAGE_ACCOUNT_NAME>"
        container_name = "tfstate"
        key = "terraform.tfstate"
    }
}
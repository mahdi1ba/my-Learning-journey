#providers.tf
terraform{
    required_providers{
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~>2.0"
        }
    }
}

provider "azurerm" {
    features     {}}
  
}

#networking.tf
resource "azurerm_resource_group" "rg" {
    name = "<RESOURCE_GROUP_NAME>"
    location = "<LOCATION>"
}

resource "azurerm_virtual_network" "vnet" {
    name = "guruVnet"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    tags = {
      Environement = "staging"
    }
}

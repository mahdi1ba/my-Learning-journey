terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">=2.26"
        }
    }
    required_version = ">= 0.14.9"
}

provider "azurerm" {
    features {}
    skip_provider_registration = true
}

#create a virtual network
resource "azurerm_virtual_network" "vnet" {
    name   = "BatmanInc"
    address_space = ["10.0.0.0/16"]
    location = "Central US"
    resource_group_name = ""
    tags = {
      Environment = "TheBatCave"
      Team = "Batman"
    }
  
}

#Create subnet

resource "azurerm_subnet" "subnet"{
    name =  "Robins"
    resource_group_name = ""
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefix = "10.0.1.0/24"
}
 
### output_azure
output "azurerm_virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "azurerm_subnet_name" {
  value = azurerm_subnet.subnet.name
}
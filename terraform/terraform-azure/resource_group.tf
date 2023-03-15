provider "azurerm" {
  
}

resource "azurerm_resource_group" "rg" {
    name = "TFResourceGroup"
    location = "eastus"
  
}

#tags
resource "aurerm_resource_group" "rg"{
    nname = "TFResourceGroup"
    location = "eastus"
    tags = {
        environment= "Terraform"
        deployedby = "Admin" 
    }
}

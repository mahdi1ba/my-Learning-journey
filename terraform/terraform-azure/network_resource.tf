#Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name = "myVnet"
    address_space = ["10.0.0.0/16"]
    location = "westus"
    resource_group_name = "TFResourceGroup"
  
}

#Create subnet
resource "azurerm_subnet" "tfsubnet" {
    name = "mySubnet"
    resource_group_name = "TFResourceGroup"
    virtual_network_name = "myVnet"
    address_prefix = "10.0.1.0/24"
}

####exemple 2
#create virtual network
resource "azurerm_virtual_network" "TFNet" {
    name = "myVnet"
    address_space = ["10.0.0.0/16"]
    location = "eastus"
    resource_group_name = "TFResourceGroup"
    virtual_network_name = azurerm_virtual_network.TFNet.name
    address_prefix = "10.0.1.0/24"
  
}

resource "azurerm_subnet" "tfsubnet2" {
    name = "subnet2"
    resource_group_name = "TFResourceGroup"
    virtual_network_name = azurerm_virtual_network.TFNet.name
    address_prefix = "10.0.2.0/24"
  
}
resource "azurerm_virtual_network" "vnet" {
    name = "guruVnet"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    
    subnet {
        name  = "guruSubnet"
        address_prefix = "10.0.1.0/24"
    }

    tags = {
      Environement = "Staging"
    }
}
##

resource "azurerm_virtual_network" "vnet" {
    name = "guruVnet"
    address_prefixes = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
      Environment = "Staging"
    }
}

resource "azurerm_subnet" "subnet" {
    name = "guruSubnet"
    address_prefixes = ["10.0.1.0/24"]
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = azurerm_resource_group.rg.name
}

##

resource "azurerm_subnet" "frontend" {
    name = "guruSubnet_1"
    address_prefixes = ["10.0.1.0/24"]
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = azurerm_resource_group.rg.name 
}

resource "azurerm_subnet" "backend" {
    name = "guruSubnet_2"
    address_prefixes = ["10.0.2.0/24"]
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = azurerm_resource_group.rg.name
}


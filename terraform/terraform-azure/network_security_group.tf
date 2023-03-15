resource "azurerm_network_security_group" "nsg"{
    name = "TestNSG"
    location = "East US"
    resource_group_name = "TFResourceGroup"
}

resource "azurerm_network_security_rule" "exemple1" {
        name  = "web80"
        priority = 1001
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = "*"
        destination_address_prefix = "*"
        resource_group_name = "TFResourceGroup"
        network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "exemple2" {
        name  = "web8080"
        priority = 1000
        direction = "Inbound"
        access = "Deny"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "8080"
        source_address_prefix = "*"
        destination_address_prefix = "*"
        resource_group_name = "TFResourceGroup"
        network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "example4" {
    name                        = "SSH"
    priority                    = 1100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = "Enter Resource group name"
    network_security_group_name = azurerm_network_security_group.nsg.name
}
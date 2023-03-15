resource "azurerm_network_security_group" "sg" {
    name =  "guruSG"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        
        name = "allow_guru"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "*"
        source_address_prefix = "*"
        destination_address_prefix = "*"

    }

    tags = {
      environement = "Staging"
    }
  
}
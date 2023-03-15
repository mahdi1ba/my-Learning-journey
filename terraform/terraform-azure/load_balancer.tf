resource "azurerm_public_ip" "pub_ip" {
    name = "guruPubIp"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method = "Static"
    domain_name_label = azurerm_resource_group.rg.name

    tags = {
        Environement = "Staging"
    }
}

resource "azurerm_lb" "lb" {
    name = "guruLB"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    frontend_ip_configuration {
        name = "PublicIPAddress"
        public_ip_address_id = azurerm_public_ip.lb.id
    }

    tags = {
      Environement = "Staging"
    }
  
}

resource "azurerm_lb_backend_address_pool" "lb_backend" {
    name = "BackEndAddressPool"
    resource_group_name  = azurerm_resource_group.rg.name
    loadbalancer_id = azurerm_lb.lb.id
  
}

resource "azurerm_lb_nat_pool" "lb_nat_pool" {
    name = "ssh"
    resource_group_name = azurerm_resource_group.rg.name
    loadbalancer_id = azurerm_lb.lb.id
    protocol = "Tcp"
    frontend_port_start = 50000
    frontend_port_end = 50119
    backend_port = 22
    frontend_ip_configuration_name = "PublicIPAddress"
  
}

resource "azurerm_lb_probe" "lb_probe" {
    name  = "http-probe"
    resource_group_name = azurerm_resource_group.rg.name
    loadbalancer_id = azurerm_lb.lb.id
    protocol = "Http"
    request_path = "/"
    port = 80
}

resource "azurerm_lb_rule" "lb_rule" {
    name = "guruLBRule"
    resource_group_name = azurerm_resource_group.rg.name
    loadbalancer_id = azurerm_lb.lb.id
    protocol = "Tcp"
    frontend_port = 3389
    backend_port = 3389
    frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurem_lb_outbound_rule" "lb_ob_rule" {
    name = "guruOBRule"
    resource_group_name = azurerm_resource_group.rg.name
    loadbalancer_id = azurerm_lb.lb.id
    protocol = "Tcp"
    backend_address_pool_id = azurerm_lb_backend_address_pool.lbbackend.id

    frontend_ip_configuration{
        name = "PublicIPAddress"
    }
  
}

resource "azurem_lb_nat_rule" "lb_nat_rule" {
    name  = "RDPAccess"
    resource_group_name = azurerm_resource_group.rg.name
    loadbalancer_id = azurerm_lb.lb.id
    protocol = "Tcp"
    frontend_port = 3389
    backend_port = 3389
    frontend_ip_configuration_name = "PublicIPAddress"
}


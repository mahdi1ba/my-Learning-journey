module "windowsservers" {
    source = "Azure/compute/azurerm"
    resource_group_name  = azurerm_resource_group.rg.name
    is_windows_image = true
    vm_hostname = "guruwinvm"
    admin_password = "Pa@@word!?"
    vm_os_simple = "windowsServer"
    public_ip_dns = ["winsimplevmips"]
    vnet_subnet_id = module.network.vnet_subnets[0]

    depends_on = [azurerm_resource_group.rg]
}

module "network" {
    source = "Azure/network/azurerm"
    resource_group_name = azurerm_resource_group.rg.name
    subnet_prefixes = ["10.0.1.0/24"]
    create_option = ["subnet"]

    depends_on = [azurerm_resource_group.rg]
  
}

output "windows_vm_public_name" {
    value = module.windowsservers.public_ip_dns_name
}

output "vm_public_ip" {
    value = module.windowsservers.public_ip_address
}

output "vm_private_ips" {
    value = module.windowsservers.network_interface_private_ip
  
}
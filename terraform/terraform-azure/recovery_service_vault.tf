resource "azurerm_recovery_services_vault" "vault" {
    name = "Terraform-recovery-vault"
    location = "East US"
    resource_group_name = "TFResourceGroup"
    sku = "Standard"
  
}
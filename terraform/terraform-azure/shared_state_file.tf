provider "azurerm" {
    version = 1.38  
}

terraform{
    backend "aurerm"{
        resource_group_name = "TFResourceGroup"
        storage_account_name = "storage4terraform"
        container_name = "statefile"
        key  = "terraform.tfsate"
    }
}

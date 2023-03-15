terraform {
    # Azure Provider
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=2.91.0"
        }
    }
}

#configure the microsoft Azure Provider
provider "azurerm" {
    features {}
    skip_provider_registration = true
  
}
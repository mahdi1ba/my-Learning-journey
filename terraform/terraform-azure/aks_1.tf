#create-remote-state-storage.tf

# resource group:

resource "azurerm_resource_group" "tfstate" {
    name = "tfstate"
    location = "eastus"
}

#random string generator

resource "random_string" "tfstate" {
    length = 5
    special = false
    upper = false
}

# azure storage

resource "azurerm_storage_account" "tfstate" {
    name = "tfstate${random_string.resource_code.result}"
    resource_group_name = azurerm_resource_group.tfstate.name
    account_tier = "Standard"
    account_replication_type = "LRS"
    allow_blob_public_access = true
    
    tags =  {
        environement = "dev"
    }
}

#azure storage container:

resource "azurerm_storage_container" "tfstate" {
    name = "tfstate"
    storage_account_name = azurerm_storage_account.tfstate.name
    container_access_type = "blob" 
}

#output

output "storage_account_name" {
    value = azurerm_storage_account.tfstate.name
}

output "storage_container_name" {
    value = azurerm_storage_container.tfstate.name
}

#providers.tf

#add the backedn configuration to the providers.tf file

backend "azurerm"{
    resource_group_name = "<RESOURCE_GROUP_NAME>"
    storage_account_Name = "<STORAGE_ACCOUNT_NAME>"
    container_name = "tfstate"
    key = "tfstate"
}

## create the service principal:

# $ az ad sp create-for-rbac --name <service_principal_name> --role contributor --scopes /subscriptions/<subscription_id>

# get the sp object ID :

# $ az ad sp list --display-name "<display_name>" --query "[].{\Object ID\":objectId}" --output table

# create an ssh key pair:

# $ ssh-key-gen -m PEM -t rsa -b 4096
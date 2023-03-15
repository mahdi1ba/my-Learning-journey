resource "azurerm_resource_group" "super-vote" {
    name = "super-vote-rg"
    location = "eastus"
}

resource "random_integer" "ri" {
    min = 10000
    max = 99999
  
}

resource "azurerm_cosmosdb_account" "super-vote" {
    name = "tfex-cosmos-db-${random_integer.ri.result}"
    location = azurerm_resource_group.super-vote.location
    resource_group_name = azurerm_resource_group.super-vote.name
    offer_type = "Standard"
    kind = "GlobalDocumentDB"

    consistency_policy {
      consistency_level = "BoundedStaleness"
      max_interval_in_seconds = 10
      max_staleness_prefix = 200
    }
    
    geo_location {
      location = "eastus"
      failover_priority = 0
    }
}

resource "azurerm_container_group" "super-vote" {
    name = "super-vote"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    ip_address_type = "public"
    dns_name_label = "super-vote"
    os_type = "linux"

    container {
        name = "super-vote"
        image = "mcr.microsoft.com/azuredocs/azure-vote-front:cosmosd"
        cpu = "0.5"
        memory = "1.5"
        ports {
            port = 80
            protocol = "TCP"
        }
        
        secure_environment_variables = {
        "COSMOS_DB_ENDPOINT" = azurerm_cosmosdb_account.vote-cosmos-db.endpoint
        "COSMOS_DB_MASTERKEY" = azurerm_cosmosdb_account.vote-cosmos-db.primary_master_key
        "TITLE" = "Better Hero Voting App"
        "VOTE1TITLE" = "Batman"
        "VOTE2VALUE" = "Superman"
        }
    }
}



output "dns" {
    value = azurerm_container_group.super-vote.fqdn
  
}
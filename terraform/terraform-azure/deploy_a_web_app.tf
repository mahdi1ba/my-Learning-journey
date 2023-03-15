resource "azurerm_app_serice_plan" "svcplan" {
    name = "newweb-appserviceplan"
    location = "eastus"
    resource_group_name = "TFResourceGroup"

    sku{
        tier = "Standard"
        size = "S1"
    }
  
}

resource "azure_app_service" "appsvc" {
    name = "custom-tf-webapp-for-thestudent"
    location = "eastus"
    resource_group_name = "TFResourceGroup"
    app_service_plan_id = azurerm_app_serice_plan.svcplan.id

    site_config{
        dotnet_framework_version = "v4.0"
        scm_type = "LocalGit"
    }
  
}
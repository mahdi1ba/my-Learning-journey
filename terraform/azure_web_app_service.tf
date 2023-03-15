provider "azurerm" {
    version = 1.38
    }


#In App Service (Web Apps, API Apps,or Mobile Apps), an app always runs in an App Service plan. 
#In addition, Azure Functions also has the option of running in an App Service plan. 
#An App Service plan defines a set of compute resources for a web app to run.
#These compute resources are analogous to the server farm in conventional web hosting. 
#One or more apps can be configured to run on the same computing resources (or in the same App Service plan).

resource "azurerm_app_service_plan" "svcplan" {
  name                = "newweb-appserviceplan"
  location            = "eastus"
  resource_group_name = "191-63408591-deploy-a-web-application-with-terrafo"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "xustom-tf-webapp-for-thestudent"
  location            = "eastus"
  resource_group_name = "191-63408591-deploy-a-web-application-with-terrafo"
  app_service_plan_id = azurerm_app_service_plan.svcplan.id


  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}
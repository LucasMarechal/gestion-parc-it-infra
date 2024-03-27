# Configuration du provider Azure et version Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

# Déclaration des ressources Azure et configuration pour héberger une application Java
resource "azurerm_resource_group" "my_resource_group" {
  name     = "myResourceGroup"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "my_app_service_plan" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_web_app" "my_web_app" {
  name                = "myWebApp"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
  app_service_plan_id = azurerm_app_service_plan.my_app_service_plan.id

  site_config {
    linux_fx_version = "JAVA|11-java11"
  }
}

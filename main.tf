terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-{votre_nom}-${random_integer.nom_entier}"
  location = "West Europe"
}

resource "random_integer" "nom_entier" {
  min = 1000
  max = 9999
}

resource "azurerm_app_service_plan" "example" {
  name                = "asp-{votre_nom}-${random_integer.nom_entier}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_linux_web_app" "example" {
  name                = "webapp-{Marechal}-${random_integer.nom_entier}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    java_version         = "1.8"
    java_container       = "TOMCAT"
    java_container_version = "8.5"
  }
}

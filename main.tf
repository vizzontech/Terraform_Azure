# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}


# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "Azure Terraform"
    Team        = "VizzonDevOps"
  }
}

#Create storage account
resource "azurerm_storage_account" "std" {
  name                     = "vizzon${random_integer.ri.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#Create container
resource "azurerm_storage_container" "std" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.std.name
  container_access_type = "private"
}

#Create app service plan 
resource "azurerm_app_service_plan" "asp" {
  name                = "vizzon-appserviceplan-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
  
}

#Creat app service
resource "azurerm_app_service" "as" {
  name                = "vizzon-appservice-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  depends_on = [ azurerm_app_service_plan.asp ]
  site_config {
    
  }

  app_settings = {
  }

}

#Create SQL Server
resource "azurerm_mssql_server" "sql" {
  name                         = "vizzon-sqlserver-${random_integer.ri.result}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "admin-${random_integer.ri.result}"
  administrator_login_password = "pa$$w0rd!"
}

#Create SQL Server Database
resource "azurerm_mssql_database" "db" {
  name         = "vizzon-db-${random_integer.ri.result}"
  server_id    = azurerm_mssql_server.sql.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = var.license_type
  max_size_gb  = var.storage_size_in_gb
  sku_name     = var.sku_name
  geo_backup_enabled = false
  depends_on = [ azurerm_mssql_server.sql ]

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}





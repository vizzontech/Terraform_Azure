output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}
output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}
output "azurerm_mssql_server_administrator_login" {
  value = azurerm_mssql_server.sql.administrator_login
}
output "azurerm_mssql_database_name" {
  value = azurerm_mssql_database.db.name
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_mssql_server" "server" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = random_password.password.result
  tags                         = var.tags
}

resource "azurerm_mssql_database" "db" {
  name      = var.db_name
  server_id = azurerm_mssql_server.server.id
  sku_name  = "S2"
  tags      = var.tags
}

resource "azurerm_mssql_firewall_rule" "azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "verification_ip" {
  name             = "allow-verification-ip"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = var.allowed_ip
  end_ip_address   = var.allowed_ip
}

resource "azurerm_key_vault_secret" "sql_user" {
  name         = "sql-admin-name"
  value        = var.admin_username
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "sql_pass" {
  name         = "sql-admin-password"
  value        = random_password.password.result
  key_vault_id = var.key_vault_id
}
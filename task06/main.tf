resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

data "azurerm_key_vault" "existing" {
  name                = var.kv_name
  resource_group_name = var.kv_rg_name
}

module "sql" {
  source              = "./modules/sql"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  server_name         = local.sql_server_name
  db_name             = local.sql_db_name
  admin_username      = var.sql_admin_username
  allowed_ip          = var.allowed_ip_address
  key_vault_id        = data.azurerm_key_vault.existing.id
  tags                = var.tags
}

module "webapp" {
  source                = "./modules/webapp"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  asp_name              = local.asp_name
  app_name              = local.app_name
  sql_connection_string = module.sql.sql_connection_string
  tags                  = var.tags
}
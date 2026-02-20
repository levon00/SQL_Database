variable "name_prefix" {
  type        = string
  description = "Prefix for resource naming"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
}

variable "kv_name" {
  type        = string
  description = "Name of the existing Key Vault"
}

variable "kv_rg_name" {
  type        = string
  description = "Resource group of the existing Key Vault"
}

variable "sql_admin_username" {
  type        = string
  description = "Administrator username for SQL Server"
}

variable "allowed_ip_address" {
  type        = string
  description = "IP address allowed to access SQL Server"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}
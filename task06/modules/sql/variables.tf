variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "server_name" { type = string }
variable "db_name" { type = string }
variable "admin_username" { type = string }
variable "allowed_ip" { type = string }
variable "key_vault_id" { type = string }
variable "tags" { type = map(string) }
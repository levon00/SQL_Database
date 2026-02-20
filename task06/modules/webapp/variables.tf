variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "asp_name" { type = string }
variable "app_name" { type = string }
variable "sql_connection_string" {
  type      = string
  sensitive = true
}
variable "tags" { type = map(string) }
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" { sensitive = true }
variable "tenant_id" {}

variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_address_space" { type = list(string) }
variable "subnet_name" {}
variable "subnet_prefixes" { type = list(string) }

variable "vm_name" {}
variable "vm_size" {}
variable "admin_username" {}
variable "admin_password" { sensitive = true }

variable "tags" { type = map(string) }

variable "ticket_api_endpoint" { description = "API endpoint for ticketing system" }
variable "ticket_api_key" { description = "API key for ticketing system", sensitive = true }

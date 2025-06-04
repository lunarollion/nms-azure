variable "resource_group_name" {
  type = string
}

variable "alert_email" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vm_id" {
  type = string
}

variable "dns_zone_id" {
  type = string
}

variable "cdn_profile_id" {
  type = string
}
variable "function_app_name" {
  description = "Name of the Azure Function App"
  type        = string
}

variable "storage_account_name" {
  description = "Storage Account name for Function App"
  type        = string
}

variable "freshservice_api_key" {
  description = "Freshservice API key for alert integration"
  type        = string
  sensitive   = true
}

variable "freshservice_domain" {
  description = "Freshservice domain (e.g. yourdomain.freshservice.com)"
  type        = string
}

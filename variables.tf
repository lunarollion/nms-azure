variable "resource_group_name" {
  type        = string
  description = "Resource group name for all monitored resources"
  default     = "POC-HYC"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

variable "client_id" {
  type        = string
  description = "Azure client ID for OIDC (App Registration)"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID for OIDC"
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_secret" {
  type        = string
  default     = ""
  description = "Azure client secret (used only when not using OIDC)"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "alert_email" {
  type        = string
  description = "The email address to receive alert notifications"
  default     = "lunar.gultom@ollion.com"
}

variable "vm_id" {
  type        = string
  description = "The resource ID of the virtual machine to monitor"
  default     = "/subscriptions/0e1373c7-d99a-4eaa-9e16-59e648375f9e/resourceGroups/apac-es-devops-lunar-gultom/providers/Microsoft.Compute/virtualMachines/POC-HYC"
}

variable "cdn_profile_id" {
  type        = string
  description = "The resource ID of the Azure CDN profile to monitor. Leave as null if not used"
  default     = null
}

variable "dns_zone_id" {
  type        = string
  description = "The resource ID of the DNS Zone to monitor. Leave as null if not used"
  default     = null
}

variable "vm_names" {
  type        = map(string)
  description = "Map of VM names (if needed for identification, logs, etc.)"
  default     = {
    "vm1" = "POC-HYC"
  }
}

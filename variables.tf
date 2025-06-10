variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
  default     = "0e1373c7-d99a-4eaa-9e16-59e648375f9e"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
  default     = "19b97404-cd9c-4a64-afa9-855f7ae4ca2d"

}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
  default     = "353846d6-a0d2-400e-8a7a-517a18e30c03"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for VMs"
  default     = "POC-HYC"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "southeastasia"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "alert_email00" {
  description = "The email address to receive alert notifications."
  type        = string
  default     = "lunar.gultom@ollion.com"
}

variable "vm_id" {
  description = "The ID of the virtual machine to monitor."
  type        = string
  default     = "50957879-1af4-449b-9375-3a499f29aa94"
}

variable "cdn_profile_id" {
  description = "The resource ID of the Azure CDN profile to monitor. Leave blank if not using CDN alerts."
  type        = string
  default     = null
}

variable "dns_zone_id" {
  description = "The resource ID of the DNS Zone to monitor. Leave blank if not using DNS alerts."
  type        = string
  default     = null
}

variable "vm_names" {
  description = "Map of VM names"
  type        = map(string)
  default     = {
    "vm1" = "POC-HYC"
  }

}




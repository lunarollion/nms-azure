variable "resource_group_name" {
  description = "The name of the resource group in which resources will be created."
  type        = string
}

variable "alert_email" {
  description = "The email address to receive alert notifications."
  type        = string
  default     = "lunar.gultom@ollion.com"
}

variable "vm_id" {
  description = "The resource ID of the virtual machine to monitor."
  type        = string
    default     = "50957879-1af4-449b-9375-3a499f29aa94"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
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
}

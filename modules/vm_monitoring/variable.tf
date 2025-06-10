variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "alert_email" {
  type        = string
  description = "Email for alert notification"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "vm_id" {
  type        = string
  description = "ID of the virtual machine"
}

variable "cdn_profile_id" {
  type        = string
  description = "CDN Profile ID"
  default     = null
}

variable "dns_zone_id" {
  type        = string
  description = "DNS Zone ID"
  default     = null
}

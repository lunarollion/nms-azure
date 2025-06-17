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
  default     = {}
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

variable "vm_names" {
  type        = map(string)
  description = "Map of VM names for identification or tagging"
  default     = {}
}

variable "virtual_machines" {
  type = list(object({
    name           = string
    location       = string
    resource_group = string
  }))
}

variable "action_group_id" {
  description = "The ID of the action group to attach to alerts"
  type        = string
}

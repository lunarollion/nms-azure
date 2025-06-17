variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where DNS and alerts reside"
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


variable "dns_zone_id" {
  type        = string
  description = "DNS Zone ID"
  default     = null
}

variable "action_group_id" {
  type        = string
  description = "ID of the Action Group used for DNS alerts"
}

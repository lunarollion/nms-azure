variable "lb_id" {
  type        = string
  description = "ID of the load balancer to monitor"
}

variable "alert_email" {
  type        = string
  description = "Email address to receive alerts"
}

variable "health_probe_status_threshold" {
  type        = number
  description = "Threshold for health probe status alerts"
}

variable "data_path_availability_threshold" {
  description = "Threshold for data path availability alert"
  type        = number
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for the alerts"
}

variable "action_group_id" {
  type        = string
  description = "ID of the Action Group to link with alerts"
  default     = ""
}

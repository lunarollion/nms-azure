variable "action_group_id" {
  type        = string
  description = "Action group ID to be used in AKS metric alerts"
}

variable "alert_email" {
  type        = string
  description = "Email to receive alerts (not used directly but good to have)"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for AKS alerts"
}

variable "cpu_usage_percentage_threshold" {
  description = "Threshold for AKS CPU usage percentage alert"
  type        = number
  default     = 75
}

variable "total_available_memory_threshold" {
  description = "Threshold for available memory in AKS in bytes"
  type        = number
  default     = 2000000000
}

variable "disk_used_percentage_threshold" {
  description = "Threshold for AKS disk used percentage"
  type        = number
  default     = 75
}

variable "number_of_pods__phase_failed_threshold" {
  description = "Threshold for the number of failed pods in AKS"
  type        = number
  default     = 0
}

variable "status_of_various_node_conditions_notready_threshold" {
  description = "Threshold for number of AKS nodes in NotReady state"
  type        = number
  default     = 0
}

variable "status_of_various_node_conditions_frequentcontainerrestart_threshold" {
  description = "Threshold for container restarts in AKS"
  type        = number
  default     = 20
}

variable "inflight_request_count_threshold" {
  description = "Threshold for inflight request count in AKS"
  type        = number
  default     = 100
}

variable "aks_id" {
  description = "ID of the AKS cluster"
  type        = string
  default     = ""
}
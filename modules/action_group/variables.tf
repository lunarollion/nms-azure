variable "name" {
  description = "Name of the Action Group"
  type        = string
}

variable "short_name" {
  description = "Short name (<=12 chars) for Action Group"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group in which to create the Action Group"
  type        = string
}

variable "email_receivers" {
  description = "List of email addresses to receive alerts"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the Action Group"
  type        = map(string)
  default     = {}
}


variable "name" {
  description = "The name of the Action Group."
  type        = string
}

variable "short_name" {
  description = "The short name (<=12 characters) for the Action Group."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Action Group."
  type        = string
}

variable "email_receivers" {
  description = "A list of email addresses to receive alert notifications."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to apply to the Action Group."
  type        = map(string)
  default     = {}
}

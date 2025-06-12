variable "name" {
  type = string
}

variable "short_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "list_of_email" {
  type        = list(string)
  description = "List of email addresss to send email notifications"
}

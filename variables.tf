variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Client Secret"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for VMs"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the Virtual Network"
}

variable "subnets" {
  type = list(object({
    name           = string
    address_prefix = string
  }))
  description = "List of subnets with name and prefix"
}

variable "virtual_machines" {
  type = list(object({
    name              = string
    location          = string
    resource_group    = string
    vm_size           = string
    admin_username    = string
    subnet_name       = string
    os_disk = object({
      name                 = string
      storage_account_type = string
      disk_size_gb         = number
    })
    data_disks = list(object({
      name                 = string
      lun                  = number
      storage_account_type = string
      disk_size_gb         = number
    }))
    extensions = list(object({
      name                      = string
      publisher                 = string
      type                      = string
      type_handler_version      = string
      auto_upgrade_minor_version = bool
    }))
  }))
  description = "List of VMs with their configurations"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VMs"
  sensitive   = true
}

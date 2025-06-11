####################################
# Azure Authentication & OIDC
####################################

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "use_oidc" {
  type    = bool
  default = false
}

####################################
# Resource Group & Location
####################################

variable "resource_group_name" {
  type        = string
  description = "Resource group name for all monitored resources"
  default     = "apac-es-devops-lunar-gultom"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

####################################
# Tags
####################################

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default = {
    environment = "poc"
    owner       = "poc-hyc"
    project     = "poc-monitoring"
  }
}

####################################
# Monitoring Targets
####################################

variable "alert_email" {
  type        = string
  description = "Email address to receive alert notifications"
  default     = "lunar.gultom@ollion.com"
}

variable "vm_id" {
  type        = string
  description = "Resource ID of the virtual machine to monitor"
  default     = "/subscriptions/0e1373c7-d99a-4eaa-9e16-59e648375f9e/resourceGroups/apac-es-devops-lunar-gultom/providers/Microsoft.Compute/virtualMachines/POC-HYC"
}

variable "vm_names" {
  type        = map(string)
  description = "Map of VM names for identification or tagging"
  default = {
    "vm1" = "poc-hyc"
  }
}

variable "virtual_machines" {
  description = "List of virtual machines to monitor"
  type = list(object({
    name           = string
    location       = string
    resource_group = string
    vm_size        = string
    subnet_name    = string
    os_disk = object({
      name                 = string
      storage_account_type = string
      disk_size_gb         = number
    })
    data_disks = list(any)
    extensions = list(any)
  }))
}

####################################
# Optional Resources
####################################

variable "cdn_profile_id" {
  type        = string
  description = "Resource ID of the Azure CDN profile to monitor (optional)"
  default     = null
}

variable "dns_zone_id" {
  type        = string
  description = "Resource ID of the DNS Zone to monitor (optional)"
  default     = null
}


####################################
# Subnets
####################################


variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "poc-hyc-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "network_interface_id" {
  type        = string
  description = "The ID of the network interface"
  default     = "/subscriptions/233e16db-2636-4f3c-8ae7-cdd9678d940b/resourceGroups/poc-hyc/providers/Microsoft.Network/networkInterfaces/poc-hyc542_z2"
}

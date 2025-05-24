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
  default     = "f8d8c41c-a3ff-4e44-abee-8eb6517b2f65"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for VMs"
  default     = "hyc-windchill-prd-rg"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "southeastasia"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
  default     = "hyc-windchill-prd-vnet"
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

variable "freshservice_webhook_url" {
  type        = string
  description = "Azure Function URL that creates tickets in Freshservice"
}

variable "virtual_machines" {
  description = "List of existing VMs to create/manage"
  type = list(object({
    name           = string
    location       = string
    resource_group = string
    vm_size        = string
    admin_username = string
    admin_password = string
    subnet_name    = string
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
  default = [
    {
      name           = "apptier-prd-vm"
      location       = "southeastasia"
      resource_group = "hyc-windchill-prd-rg"
      vm_size        = "Standard_A8m_v2"
      admin_username = "hycadmin"
      admin_password = "YourPasswordHere!" # recommend moving to sensitive var or secret store
      subnet_name    = "apptier-prd-subnet"
      os_disk = {
        name                 = "apptier-prd-vm_OsDisk_1_b61e89de0307453e9848ef27a948a526"
        storage_account_type = "StandardSSD_LRS"
        disk_size_gb         = 127
      }
      data_disks = [
        {
          name                 = "apptier-prd-vm_DataDisk_0"
          lun                  = 0
          storage_account_type = "StandardSSD_LRS"
          disk_size_gb         = 250
        },
        {
          name                 = "apptier-prd-vm_DataDisk_1"
          lun                  = 2
          storage_account_type = "Standard_LRS"
          disk_size_gb         = 1024
        }
      ]
      extensions = [
        {
          name                      = "AzureNetworkWatcherExtension"
          publisher                 = "Microsoft.Azure.NetworkWatcher"
          type                      = "NetworkWatcherAgentWindows"
          type_handler_version      = "1.4"
          auto_upgrade_minor_version = true
        }
      ]
    }
  ]
}

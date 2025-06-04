variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
  default     = "0e1373c7-d99a-4eaa-9e16-59e648375f9e"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
  default     = "19b97404-cd9c-4a64-afa9-855f7ae4ca2d"

}

variable "client_secret" {
  type        = string
  description = "Azure Client Secret"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
  default     = "353846d6-a0d2-400e-8a7a-517a18e30c03"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for VMs"
  default     = "POC-HYC"
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
  default     = "POC-HYC-vnet"
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

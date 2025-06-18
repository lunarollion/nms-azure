terraform {
  backend "azurerm" {
    resource_group_name  = "apac-es-devops-lunar-gultom"
    storage_account_name = "hyctfstatestore"
    container_name       = "hyctfstate"
    key                  = "hyc-prod.terraform.tfstate"
  }
}

module "action_group" {
  source              = "./modules/action_group"
  name                = "POCAutomateAlert"
  short_name          = "poc-alert"
  resource_group_name = "apac-es-devops-lunar-gultom"
  email_receivers     = ["lunar.gultom@gmail.com"]

  tags = {
    environment = "prod"
    owner       = "ollion"
  }

  providers = {
    azurerm = azurerm.hyc
  }
}

# MODULE: alert_vm

module "vm_monitoring" {
  source              = "./modules/alert_vm"
  resource_group_name = var.resource_group_name
  alert_email         = var.alert_email
  vm_id               = var.vm_id
  tags                = var.tags
  cdn_profile_id      = var.cdn_profile_id
  dns_zone_id         = var.dns_zone_id
  vm_names            = var.vm_names
  virtual_machines    = var.virtual_machines

  action_group_id = module.action_group.id

  providers = {
    azurerm = azurerm.hyc
  }
}

# MODULE: alert_dns

module "dns_monitoring" {
  source              = "./modules/alert_dns"
  resource_group_name = var.resource_group_name
  alert_email         = var.alert_email
  tags                = var.tags
  dns_zone_id         = var.dns_zone_id

  action_group_id = module.action_group.id

  providers = {
    azurerm = azurerm.hyc
  }
}

# MODULE: alert_aks
module "alert_aks" {
  count = var.lb_id != "" ? 1 : 0 ## REMOVE THIS IF THE CUSTOMER HAVE A EKS and put ID AKS in variables
  source                  = "./modules/alert_aks"
  aks_id                  = var.aks_id
  resource_group_name     = var.resource_group_name
  alert_email             = var.alert_email

  action_group_id         = module.action_group.id

  providers = {
    azurerm = azurerm.hyc
  }
}

module "alert_loadbalancer" {
  count = var.lb_id != "" ? 1 : 0  ## REMOVE THIS IF THE CUSTOMER HAVE A EKS and put ID loadBalancers in variables
  source = "./modules/alert_loadbalancer"

  resource_group_name              = var.resource_group_name
  lb_id                            = var.lb_id
  alert_email                      = var.alert_email
  action_group_id                  = module.action_group.id
  health_probe_status_threshold    = 2
  data_path_availability_threshold = 80

  providers = {
    azurerm = azurerm.hyc
  }
}


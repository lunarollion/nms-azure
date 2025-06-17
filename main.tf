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


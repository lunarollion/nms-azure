module "monitoring" {
  source = "./modules/monitoring_module"

  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_machine_ids = module.vm_infrastructure.virtual_machine_ids
  tags                = var.tags
  alert_email         = "lunar.gultom@ollion.com"
}

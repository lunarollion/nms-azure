module "vm_modules" {
  source = "./modules/vm_modules"
  # other vars
}

module "vm_monitoring" {
  source = "./modules/vm_monitoring"
  
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_id               = module.vm.vm_id  # <-- reference output from VM module
  tags                = var.tags
  alert_email         = "lunar.gultom@ollion.com"
}

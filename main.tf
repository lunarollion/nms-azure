
module "vm_monitoring" {
  source              = "./modules/vm_monitoring"
  resource_group_name = var.resource_group_name
  alert_email         = var.alert_email00
  vm_id               = module.vm_monitoring.vm_id
  tags                = var.tags
  cdn_profile_id      = var.cdn_profile_id
  dns_zone_id         = var.dns_zone_id
  vm_names            = var.vm_names
  
}

module "vm_monitoring" {
  source = "./modules/vm_monitoring"

  resource_group_name = var.resource_group_name
  location            = var.location
  vm_id               = "/subscriptions/0e1373c7-d99a-4eaa-9e16-59e648375f9e/resourceGroups/apac-es-devops-lunar-gultom/providers/Microsoft.Compute/virtualMachines/POC-HYC"
  tags                = var.tags
  alert_email         = "lunar.gultom@ollion.com"
}

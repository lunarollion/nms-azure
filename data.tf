data "azurerm_virtual_machine" "existing_vms" {
  for_each       = { for vm in var.virtual_machines : vm.name => vm }
  name           = each.value.name
  resource_group = each.value.resource_group
}
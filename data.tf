data "azurerm_virtual_machine" "existing_vms" {
  for_each            = { for vm in var.virtual_machines : vm.name => vm }
  name                = each.value.name
  resource_group_name = each.value.resource_group
}

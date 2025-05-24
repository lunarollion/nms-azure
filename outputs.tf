output "vm_public_ip_addresses" {
  description = "Public IP addresses of the VMs"
  value = {
    for vm_name, vm in azurerm_public_ip.pip :
    vm_name => vm.ip_address
  }
}

output "vm_ids" {
  description = "IDs of created virtual machines"
  value = {
    for vm_name, vm in azurerm_windows_virtual_machine.vm :
    vm_name => vm.id
  }
}

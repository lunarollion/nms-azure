provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

#############################
# Resource Group for VM
#############################
resource "azurerm_resource_group" "vm_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

#############################
# Virtual Network
#############################
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name
  tags                = var.tags
}

#############################
# Subnets (multiple)
#############################
resource "azurerm_subnet" "subnet" {
  for_each             = { for subnet in var.subnets : subnet.name => subnet }
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.vm_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.address_prefix]
}

#############################
# Public IP (one per VM)
#############################
resource "azurerm_public_ip" "pip" {
  for_each = { for vm in var.virtual_machines : vm.name => vm }
  name                = "${each.value.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

#############################
# Network Interface (one per VM)
#############################
resource "azurerm_network_interface" "nic" {
  for_each = { for vm in var.virtual_machines : vm.name => vm }
  name                = "${each.value.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.value.subnet_name].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
  }

  tags = var.tags
}

#############################
# Windows Virtual Machines (multiple)
#############################
resource "azurerm_windows_virtual_machine" "vm" {
  for_each = { for vm in var.virtual_machines : vm.name => vm }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  location            = each.value.location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password      = var.admin_password # or use each.value.admin_password if you store it there
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    name                 = each.value.os_disk.name
    caching              = "ReadWrite"
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  dynamic "data_disk" {
    for_each = each.value.data_disks
    content {
      lun                  = data_disk.value.lun
      caching              = "None"
      storage_account_type = data_disk.value.storage_account_type
      disk_size_gb         = data_disk.value.disk_size_gb
      create_option        = "Empty"
    }
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = var.tags
}

#############################
# VM Extensions (multiple)
#############################
resource "azurerm_virtual_machine_extension" "vm_extension" {
  for_each = {
    for vm in var.virtual_machines :
    vm.name => vm
    if length(vm.extensions) > 0
  }

  name                 = each.value.extensions[0].name
  virtual_machine_id   = azurerm_windows_virtual_machine.vm[each.key].id
  publisher            = each.value.extensions[0].publisher
  type                 = each.value.extensions[0].type
  type_handler_version = each.value.extensions[0].type_handler_version
  auto_upgrade_minor_version = each.value.extensions[0].auto_upgrade_minor_version
}

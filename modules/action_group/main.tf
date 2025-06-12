provider "azurerm" {
  features {}
}

resource "azurerm_monitor_action_group" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  short_name          = var.short_name

  dynamic "email_receiver" {
    for_each = var.list_of_email

    content {
      name          = email_receiver.value
      email_address = email_receiver.value
    }
  }
}
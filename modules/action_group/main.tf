provider "azurerm" {
  features {}
}

resource "azurerm_monitor_action_group" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  short_name          = var.short_name

  dynamic "email_receiver" {
    for_each = var.email_receivers

    content {
      name                    = replace(email_receiver.value, "@", "_")
      email_address           = email_receiver.value
      use_common_alert_schema = true
    }
  }

  tags = var.tags
}

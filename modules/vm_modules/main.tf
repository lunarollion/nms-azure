resource "azurerm_monitor_action_group" "email_alerts" {
  name                = "vm-alert-action-group"
  resource_group_name = var.resource_group_name
  location            = var.location
  short_name          = "vmalerts"

  email_receiver {
    name                    = "default-email"
    email_address           = var.alert_email
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "vm_cpu_alert" {
  for_each            = toset(var.virtual_machine_ids)
  name                = "cpu-alert-${replace(each.value, "/.*\\//", "")}"
  resource_group_name = var.resource_group_name
  location            = var.location
  scopes              = [each.value]
  description         = "Alert if CPU usage is greater than 80% for 5 minutes"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_alerts.id
  }

  tags = var.tags
}

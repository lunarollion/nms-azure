variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_id" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "alert_email" {
  type = string
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${replace(var.vm_id, "/subscriptions/.*/resourceGroups/.*/providers/Microsoft.Compute/virtualMachines/", "")}-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "vm_diagnostics" {
  name                       = "diag-${replace(var.vm_id, "/subscriptions/.*/resourceGroups/.*/providers/Microsoft.Compute/virtualMachines/", "")}"
  target_resource_id         = var.vm_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  logs {
    category = "VMInsights"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 30
    }
  }

  metrics {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}

resource "azurerm_monitor_action_group" "alert_group" {
  name                = "${replace(var.vm_id, "/subscriptions/.*/resourceGroups/.*/providers/Microsoft.Compute/virtualMachines/", "")}-alert-ag"
  resource_group_name = var.resource_group_name
  short_name          = "ag-${substr(replace(var.vm_id, "/subscriptions/.*/resourceGroups/.*/providers/Microsoft.Compute/virtualMachines/", ""), 0, 6)}"

  email_receiver {
    name          = "email_receiver"
    email_address = var.alert_email
  }
}

resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "${replace(var.vm_id, "/subscriptions/.*/resourceGroups/.*/providers/Microsoft.Compute/virtualMachines/", "")}-cpu-high"
  resource_group_name = var.resource_group_name
  scopes              = [var.vm_id]
  description         = "Alert on CPU > 80%"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_group.id
  }
}

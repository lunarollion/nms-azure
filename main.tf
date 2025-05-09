provider "azurerm" {
  features {}
}

resource "azurerm_monitor_action_group" "default" {
  name                = "vm-alert-actiongroup"
  resource_group_name = var.resource_group_name
  short_name          = "vmalert"

  email_receiver {
    name          = "admin"
    email_address = var.email_receiver
  }
}

# CPU Alert (Metric-based)
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "cpu-high-alert"
  resource_group_name = var.resource_group_name
  location            = var.location
  scopes              = [var.vm_id]
  description         = "Alert when CPU > 80% for 5 minutes"
  severity            = 3
  enabled             = true
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
    action_group_id = azurerm_monitor_action_group.default.id
  }
}

# VM Power State Alert
resource "azurerm_monitor_metric_alert" "vm_status_alert" {
  name                = "vm-status-alert"
  resource_group_name = var.resource_group_name
  location            = var.location
  scopes              = [var.vm_id]
  description         = "Alert if VM is not running"
  severity            = 2
  enabled             = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Power State"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 1
  }

  action {
    action_group_id = azurerm_monitor_action_group.default.id
  }
}

# Memory Alert (Log Analytics Query)
resource "azurerm_monitor_scheduled_query_rules_alert" "memory_alert" {
  name                = "vm-memory-usage"
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = "Alert if Memory usage > 80%"
  enabled             = true
  severity            = 2
  frequency           = 5
  time_window         = 5
  scopes              = [var.workspace_id]
  rule_type           = "LogAlert"

  criteria {
    query            = <<-KQL
      Perf
      | where ObjectName == "Memory" and CounterName == "% Committed Bytes In Use"
      | summarize avg(CounterValue) by Computer, bin(TimeGenerated, 5m)
      | where avg_CounterValue > 80
    KQL
    time_aggregation = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group = [azurerm_monitor_action_group.default.id]
  }
}

# Disk IOPS Alert (Log Analytics Query)
resource "azurerm_monitor_scheduled_query_rules_alert" "disk_iops_alert" {
  name                = "vm-disk-iops-usage"
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = "Alert if Disk IOPS > 500"
  enabled             = true
  severity            = 2
  frequency           = 5
  time_window         = 5
  scopes              = [var.workspace_id]
  rule_type           = "LogAlert"

  criteria {
    query            = <<-KQL
      Perf
      | where ObjectName == "LogicalDisk" and CounterName in ("Disk Reads/sec", "Disk Writes/sec")
      | summarize avg(CounterValue) by bin(TimeGenerated, 5m), Computer
      | where avg_CounterValue > 500
    KQL
    time_aggregation = "Average"
    operator         = "GreaterThan"
    threshold        = 500
  }

  action {
    action_group = [azurerm_monitor_action_group.default.id]
  }
}


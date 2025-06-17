terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

#####################################
# VM Alert - High CPU
#####################################
resource "azurerm_monitor_metric_alert" "high_cpu_alert" {
  name                = "high_cpu_alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.vm_id]
  description         = "Alert when CPU usage exceeds 10%"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 10
  }

  action {
    action_group_id = var.action_group_id
  }
}

#####################################
# VM Alert - Memory < 10 GB
#####################################
resource "azurerm_monitor_metric_alert" "low_memory_bytes_alert" {
  name                = "low_memory_alert_10gb"
  resource_group_name = var.resource_group_name
  scopes              = [var.vm_id]
  description         = "Alert when available memory is below 10 GB"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 10000000000
  }

  action {
    action_group_id = var.action_group_id
  }
}



resource "azurerm_monitor_metric_alert" "low_memory_percentage" {
  name                = "low_memory_alert_10percent"
  resource_group_name = var.resource_group_name
  scopes              = [var.vm_id]
  description         = "Alert when available memory is below 10%"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 10
  }

  action {
    action_group_id = var.action_group_id
  }
}

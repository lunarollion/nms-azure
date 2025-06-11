terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

resource "azurerm_monitor_action_group" "poc_alert" {
  name                = "POCAutomateAlert"
  resource_group_name = var.resource_group_name
  short_name          = "poc-alert"

  email_receiver {
    name                    = "default-email"
    email_address           = var.alert_email
    use_common_alert_schema = true
  }

  tags = var.tags
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
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}



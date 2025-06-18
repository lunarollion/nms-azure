terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

###########################################
# LB Alert - Health Probe Status < 50
###########################################
resource "azurerm_monitor_metric_alert" "lb_health_probe_status" {
  name                = "lb_health_probe_status_alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.lb_id] # should be the full LB resource ID
  description         = "Alert when Load Balancer health probe status is below threshold"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Network/loadBalancers"
    metric_name      = "DipAvailability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = var.health_probe_status_threshold
  }

  action {
    action_group_id = var.action_group_id
  }
}

###########################################
# LB Alert - Data Path Availability < Threshold
###########################################
resource "azurerm_monitor_metric_alert" "lb_data_path_availability" {
  name                = "lb_data_path_availability_alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.lb_id] # full Load Balancer resource ID
  description         = "Alert when data path availability is below threshold"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Network/loadBalancers"
    metric_name      = "SnatConnectionCount"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = var.data_path_availability_threshold
  }

  action {
    action_group_id = var.action_group_id
  }
}

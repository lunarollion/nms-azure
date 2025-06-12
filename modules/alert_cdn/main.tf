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
# DNS Zone - Query Failures
#####################################
resource "azurerm_monitor_metric_alert" "dns_query_failure" {
  count               = var.dns_zone_id != null ? 1 : 0
  name                = "dns_query_failure"
  resource_group_name = var.resource_group_name
  scopes              = [var.dns_zone_id]
  description         = "Alert if DNS QueryFailureCount > 5 in 5 minutes"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Network/dnszones"
    metric_name      = "QueryFailureCount"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 5
  }

  action {
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}


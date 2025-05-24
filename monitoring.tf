variable "resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = "apac-es-devops-lunar-gultom"
}

variable "vm_id" {
  type        = string
  description = "ID of the VM to monitor"
  default     = "/subscriptions/0e1373c7-d99a-4eaa-9e16-59e648375f9e/resourceGroups/apac-es-devops-lunar-gultom/providers/Microsoft.Compute/virtualMachines/POCTesting"
}

resource "azurerm_monitor_action_group" "poc_automate_alert" {
  name                = "POCAutomateAlert"
  resource_group_name = var.resource_group_name
  short_name          = "poc-alert"

  email_receiver {
    name                  = "AdminEmail"
    email_address         = "lunar.gultom@ollion.com"
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_metric_alert" "high_cpu_alert" {
  name                = "HighCPUAlert"
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
    action_group_id = azurerm_monitor_action_group.poc_automate_alert.id
  }
}

resource "azurerm_monitor_action_group" "poc_alert" {
  name                = "POCAutomateAlert"
  resource_group_name = var.resource_group_name
  short_name          = "poc-alert"

  email_receiver {
    name                  = "AdminEmail"
    email_address         = "lunar.gultom@ollion.com"
    use_common_alert_schema = true
  }
}

# DNS Zones Query Failure Count > 5 in 5 minutes
resource "azurerm_monitor_metric_alert" "dns_query_failure" {
  name                = "DNSQueryFailureCount"
  resource_group_name = var.resource_group_name
  scopes              = [var.dns_zone_id]   # Pass your DNS zone resource ID here
  description         = "Alert if QueryFailureCount > 5 in 5 minutes"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Network/dnszones"
    metric_name      = "QueryFailureCount"
    aggregation     = "Total"
    operator        = "GreaterThan"
    threshold       = 5
  }

  action {
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}

# CDN profile alerts

resource "azurerm_monitor_metric_alert" "cdn_client_request_count" {
  name                = "CDNClientRequestCount"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]  # Pass your CDN profile resource ID here
  description         = "Number of requests received from users (5 min)"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Cdn/profiles"
    metric_name      = "ClientRequestCount"
    aggregation     = "Total"
    operator        = "GreaterThan"
    threshold       = 0  # This just tracks total requests, alerting if > 0 (adjust logic if needed)
  }

  action {
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}

resource "azurerm_monitor_metric_alert" "cdn_http_5xx" {
  name                = "CDNHttpStatusCodeCount5xx"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if 5xx status codes > 1% of total requests OR > 50 per minute"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  dynamic "criteria" {
    for_each = [
      {
        metric_name = "HttpStatusCodeCount_5xx"
        operator    = "GreaterThan"
        threshold   = 50
        aggregation = "Total"
      },
      {
        metric_name = "HttpStatusCodePercentage_5xx"
        operator    = "GreaterThan"
        threshold   = 1
        aggregation = "Average"
      }
    ]
    content {
      metric_namespace = "Microsoft.Cdn/profiles"
      metric_name      = criteria.value.metric_name
      aggregation      = criteria.value.aggregation
      operator         = criteria.value.operator
      threshold        = criteria.value.threshold
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}

resource "azurerm_monitor_metric_alert" "cdn_failed_requests" {
  name                = "CDNFailedRequests"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if failed requests > 5% of total (4xx/5xx) in 5 min"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Cdn/profiles"
    metric_name      = "FailedRequests"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 5  # This depends on your exact metric meaning, adjust accordingly
  }

  action {
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}

resource "azurerm_monitor_metric_alert" "cdn_response_status" {
  name                = "CDNResponseStatus"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if ResponseStatus > 100 in 5 minutes"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Cdn/profiles"
    metric_name      = "ResponseStatus"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 100
  }

  action {
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}

resource "azurerm_monitor_metric_alert" "cdn_frontend_request_count" {
  name                = "CDNFrontendRequestCount"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if FrontendRequestCount < 0 (Failing) in 5 min"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Cdn/profiles"
    metric_name      = "FrontendRequestCount"
    aggregation      = "Total"
    operator         = "LessThan"
    threshold        = 0
  }

  action {
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}

resource "azurerm_monitor_metric_alert" "cdn_latency" {
  name                = "CDNLatency"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if Latency > 2000 ms in 5 minutes"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Cdn/profiles"
    metric_name      = "Latency"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 2000
  }

  action {
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}

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

# Alert: High CPU on VM
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

# Alert: DNS Query Failure
resource "azurerm_monitor_metric_alert" "dns_query_failure" {
  count               = var.dns_zone_id == null ? 0 : 1
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

# Alert: CDN 5xx errors (count + percentage)
resource "azurerm_monitor_metric_alert" "cdn_http_5xx" {
  count               = var.cdn_profile_id == null ? 0 : 1
  name                = "cdn_http_5xx"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if 5xx status codes > 1% or > 50 per minute"
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

# Alert: Failed CDN Requests
resource "azurerm_monitor_metric_alert" "cdn_failed_requests" {
  count               = var.cdn_profile_id == null ? 0 : 1
  name                = "cdn_failed_requests"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if failed requests > 5 in 5 min"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Cdn/profiles"
    metric_name      = "FailedRequests"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 5
  }

  action {
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}

# Alert: CDN Latency
resource "azurerm_monitor_metric_alert" "cdn_latency" {
  count               = var.cdn_profile_id == null ? 0 : 1
  name                = "cdn_latency"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if latency > 2000 ms"
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

# Alert: Frontend Request Count
resource "azurerm_monitor_metric_alert" "cdn_frontend_request_count" {
  count               = var.cdn_profile_id == null ? 0 : 1
  name                = "cdn_frontend_request_count"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if FrontendRequestCount < 0"
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

# Alert: Response Status (custom)
resource "azurerm_monitor_metric_alert" "cdn_response_status" {
  count               = var.cdn_profile_id == null ? 0 : 1
  name                = "cdn_response_status"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if ResponseStatus > 100"
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

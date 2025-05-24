resource "azurerm_monitor_action_group" "poc_alert" {
  name                = "POCAutomateAlert"
  resource_group_name = var.resource_group_name
  short_name          = "poc-alert"

  email_receiver {
    email_address           = var.alert_email
    use_common_alert_schema = true
  }

  tags = var.tags
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
    action_group_id = azurerm_monitor_action_group.poc_alert.id
  }
}

resource "azurerm_monitor_metric_alert" "dns_query_failure" {
  name                = "DNSQueryFailureCount"
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

resource "azurerm_monitor_metric_alert" "cdn_http_5xx" {
  name                = "CDNHttpStatusCodeCount5xx"
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

resource "azurerm_monitor_metric_alert" "cdn_failed_requests" {
  name                = "CDNFailedRequests"
  resource_group_name = var.resource_group_name
  scopes              = [var.cdn_profile_id]
  description         = "Alert if failed requests > 5% in 5 min"
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

resource "azurerm_monitor_metric_alert" "cdn_latency" {
  name                = "CDNLatency"
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

resource "azurerm_monitor_metric_alert" "cdn_frontend_request_count" {
  name                = "CDNFrontendRequestCount"
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

resource "azurerm_monitor_metric_alert" "cdn_response_status" {
  name                = "CDNResponseStatus"
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

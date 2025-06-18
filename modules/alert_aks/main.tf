terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

#####################################
# AKS Alert - CPU Usage %
#####################################
resource "azurerm_monitor_metric_alert" "aks_cpu_usage" {
  name                = "aks_cpu_usage_alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Alert when AKS CPU usage exceeds threshold"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "CPUUsage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.cpu_usage_percentage_threshold
  }

  action {
    action_group_id = var.action_group_id
  }
}

#####################################
# AKS Alert - Available Memory Bytes
#####################################
resource "azurerm_monitor_metric_alert" "aks_memory_available" {
  name                = "aks_available_memory_alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Alert when available memory in AKS is below threshold"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "MemoryRss"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = var.total_available_memory_threshold
  }

  action {
    action_group_id = var.action_group_id
  }
}

#####################################
# AKS Alert - Disk Used %
#####################################
resource "azurerm_monitor_metric_alert" "aks_disk_used" {
  name                = "aks_disk_used_alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Alert when AKS disk usage exceeds threshold"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "DiskUsedPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.disk_used_percentage_threshold
  }

  action {
    action_group_id = var.action_group_id
  }
}

#####################################
# AKS Alert - Failed Pods
#####################################
resource "azurerm_monitor_metric_alert" "aks_failed_pods" {
  name                = "aks_failed_pods_alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Alert when failed pods count exceeds threshold"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "PodsFailed"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.number_of_pods__phase_failed_threshold
  }

  action {
    action_group_id = var.action_group_id
  }
}

#####################################
# AKS Alert - Not Ready Nodes
#####################################
resource "azurerm_monitor_metric_alert" "aks_node_not_ready" {
  name                = "aks_node_not_ready_alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Alert when node NotReady count exceeds threshold"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "NodeNotReadyCount"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.status_of_various_node_conditions_notready_threshold
  }

  action {
    action_group_id = var.action_group_id
  }
}

#####################################
# AKS Alert - Frequent Container Restarts
#####################################
resource "azurerm_monitor_metric_alert" "aks_frequent_container_restart" {
  name                = "aks_frequent_restart_alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Alert for frequent container restarts in AKS"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "ContainerRestartCount"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.status_of_various_node_conditions_frequentcontainerrestart_threshold
  }

  action {
    action_group_id = var.action_group_id
  }
}

#####################################
# AKS Alert - Inflight Requests
#####################################
resource "azurerm_monitor_metric_alert" "aks_inflight_requests" {
  name                = "aks_inflight_request_alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Alert when inflight request count exceeds threshold"
  severity            = 3
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "InflightRequestCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.inflight_request_count_threshold
  }

  action {
    action_group_id = var.action_group_id
  }
}

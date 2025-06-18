output "aks_alert_ids" {
  description = "List of all AKS alert resource IDs"
  value = [
    azurerm_monitor_metric_alert.aks_cpu_usage.id,
    azurerm_monitor_metric_alert.aks_memory_available.id,
    azurerm_monitor_metric_alert.aks_disk_used.id,
    azurerm_monitor_metric_alert.aks_failed_pods.id,
    azurerm_monitor_metric_alert.aks_node_not_ready.id,
    azurerm_monitor_metric_alert.aks_frequent_container_restart.id,
    azurerm_monitor_metric_alert.aks_inflight_requests.id,
  ]
}

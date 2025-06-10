output "action_group_id" {
  description = "The ID of the action group used in alerts."
  value       = azurerm_monitor_action_group.poc_alert.id
}

output "high_cpu_alert_id" {
  description = "The ID of the high CPU usage alert."
  value       = azurerm_monitor_metric_alert.high_cpu_alert.id
}

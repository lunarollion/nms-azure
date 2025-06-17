output "high_cpu_alert_id" {
  description = "The ID of the high CPU usage alert."
  value       = azurerm_monitor_metric_alert.high_cpu_alert.id
}

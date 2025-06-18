output "lb_health_probe_status_alert_id" {
  description = "The ID of the Load Balancer Health Probe Status alert"
  value       = azurerm_monitor_metric_alert.lb_health_probe_status.id
}

output "lb_data_path_availability_alert_id" {
  description = "The ID of the Load Balancer Data Path Availability alert"
  value       = azurerm_monitor_metric_alert.lb_data_path_availability.id
}

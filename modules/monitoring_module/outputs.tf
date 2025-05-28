output "action_group_id" {
  description = "The ID of the action group created"
  value       = azurerm_monitor_action_group.email_alerts.id
}
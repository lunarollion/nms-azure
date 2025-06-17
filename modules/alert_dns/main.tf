terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

###################################################
# DNS Activity Log Alert: Write operation to DNS Zone
###################################################
resource "azurerm_monitor_activity_log_alert" "dns_zone_write_alert" {
  name                = "dns-zone-write-alert"
  resource_group_name = var.resource_group_name
  location            = "global"

  scopes      = [var.dns_zone_id]
  description = "Alert when DNS zone is modified"
  enabled     = true

  criteria {
    category       = "Administrative"
    operation_name = "Microsoft.Network/dnszones/write"
    level          = "Informational"
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

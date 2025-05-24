provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

#################################
# Production VM Infrastructure
#################################

# Resource Group for VM
resource "azurerm_resource_group" "vm_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.vm_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefixes
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.vm_name}-osdisk"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = var.tags
}

#################################
# Monitoring + Alerting Stack
#################################

# Resource Group for Monitoring
resource "azurerm_resource_group" "monitor_rg" {
  name     = "rg-monitor-ticketing"
  location = "East US"
}

resource "azurerm_log_analytics_workspace" "log" {
  name                = "loganalytics-monitor"
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appi" {
  name                = "appi-monitor-demo"
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.log.id
}

resource "azurerm_storage_account" "sa" {
  name                     = "storageacctmonitor"
  resource_group_name      = azurerm_resource_group.monitor_rg.name
  location                 = azurerm_resource_group.monitor_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "asp-monitor"
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  os_type             = "Linux"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "func" {
  name                       = "func-monitor-ticketing"
  location                   = azurerm_resource_group.monitor_rg.location
  resource_group_name        = azurerm_resource_group.monitor_rg.name
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  app_service_plan_id        = azurerm_app_service_plan.asp.id
  os_type                    = "linux"
  version                    = "~4"
  runtime_stack              = "python"

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "python"
    "TICKET_API_ENDPOINT"      = var.ticket_api_endpoint
    "TICKET_API_KEY"           = var.ticket_api_key
  }
}

resource "azurerm_monitor_action_group" "action_group" {
  name                = "ag-monitor-ticket"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "agmon"

  azure_function {
    function_app_resource_id = azurerm_function_app.func.id
    function_name            = "TicketNotifier"
    http_trigger_url         = "https://${azurerm_function_app.func.default_hostname}/api/TicketNotifier"
  }
}

resource "azurerm_monitor_metric_alert" "alert" {
  name                = "metric-alert-failure"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  scopes              = [azurerm_application_insights.appi.id]
  description         = "Alert on failed requests"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "microsoft.insights/components"
    metric_name      = "requests/failed"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 10
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group.id
  }
}

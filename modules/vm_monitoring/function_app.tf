variable "resource_group_name" {}
variable "location" {}
variable "function_app_name" {}
variable "storage_account_name" {}
variable "freshservice_api_key" {}
variable "freshservice_domain" {}

resource "azurerm_storage_account" "function_storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "function_container" {
  name                  = "function-code"
  storage_account_name  = azurerm_storage_account.function_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "function_zip" {
  name                   = "function_app.zip"
  storage_account_name   = azurerm_storage_account.function_storage.name
  storage_container_name = azurerm_storage_container.function_container.name
  type                   = "Block"
  source                 = "function_app/function_app.zip"  # Path to your zipped function app code
}

resource "azurerm_app_service_plan" "function_plan" {
  name                = "${var.function_app_name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "FunctionApp"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "function" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_app_service_plan.function_plan.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  version                    = "~4"
  os_type                   = "linux"

  site_config {
    linux_fx_version = "Python|3.9"
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME   = "python"
    WEBSITE_RUN_FROM_PACKAGE   = azurerm_storage_blob.function_zip.url
    FRESHSERVICE_API_KEY       = var.freshservice_api_key
    FRESHSERVICE_DOMAIN        = var.freshservice_domain
  }
}

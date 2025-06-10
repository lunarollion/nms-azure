provider "azurerm" {
  features {}
  use_oidc        = true
  subscription_id = var.subscription_id
}

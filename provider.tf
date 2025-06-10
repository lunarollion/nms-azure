provider "azurerm" {
  features = {}
  use_oidc = var.use_oidc
  client_id = var.client_id
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
}
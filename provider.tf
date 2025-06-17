provider "azurerm" {
  alias           = "hyc"
  use_oidc        = true
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id

  features {}
}

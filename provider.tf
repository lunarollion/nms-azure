provider "azurerm" {
  use_oidc       = true
  tenant_id      = var.tenant_id
  subscription_id = var.subscription_id
  client_id      = var.client_id

  features {}
}

provider "azurerm" {
  alias           = "hyc"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  use_oidc        = var.use_oidc
  features {}
}


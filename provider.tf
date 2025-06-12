# Default provider (required)
provider "azurerm" {
  features {}
}

# for customer HYC
provider "azurerm" {
  alias           = "hyc"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  use_oidc        = var.use_oidc
  features {}
}

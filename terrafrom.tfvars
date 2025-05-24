# terraform.tfvars

subscription_id = "d68c21d0-1b10-408a-b2cb-8d7c4580a42c"
client_id       = "your-client-id"         # Replace with actual client_id or use Azure CLI
client_secret   = "your-client-secret"     # Use env vars or Azure Key Vault in real deployments
tenant_id       = "your-tenant-id"         # Replace with actual tenant_id

resource_group_name = "hyc-windchill-prd-rg"
location            = "Southeast Asia"

vnet_name           = "hyc-windchill-prd-vnet"
vnet_address_space  = ["10.0.0.0/16"]        # You may need to check and update
subnet_name         = "apptier-prd-subnet"
subnet_prefixes     = ["10.0.1.0/24"]        # You may need to check and update

tags = {
  environment = "production"
  owner       = "lunar.gultom@yourdomain.com"
}

vm_size        = "Standard_A8m_v2"
admin_username = "azureuser"
admin_password = "ChangeMe123!"  # Replace with secure value or use Azure Key Vault
vm_name        = "windchill-prd-vm"

resource "azurerm_public_ip" "main" {
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

dns_settings {
  domain_name_label = "windchill-prd"
}

# ======================
# Azure Authentication
# ======================
subscription_id = "233e16db-2636-4f3c-8ae7-cdd9678d940b"
tenant_id       = "c2527675-3255-43a3-97c4-670a9c20d5c8"
client_id       = "9e9bbc03-edc2-493c-986d-610e52a70682"

# ======================
# Resource Group and Tags
# ======================
resource_group_name = "poc-hyc"
location            = "westus3"

tags = {
  environment = "poc"
  owner       = "poc-hyc"
  project     = "poc-monitoring"
}

# ======================
# Virtual Network & Subnets
# ======================
vnet_name          = "poc-hyc-vnet"
vnet_address_space = ["10.0.0.0/16"]

subnets = [
  {
    name           = "subnet1"
    address_prefix = "10.0.0.0/24"
  },
  {
    name           = "subnet2"
    address_prefix = "10.0.1.0/24"
  },
  {
    name           = "subnet3"
    address_prefix = "10.0.2.0/24"
  }
]

# ======================
# Virtual Machine Details
# ======================
virtual_machines = [
  {
    name           = "poc-hyc"
    location       = "westus3"
    resource_group = "poc-hyc"
    vm_size        = "Standard_B1s"
    subnet_name    = "subnet1"

    os_disk = {
      name                 = "poc-hyc_OsDisk_1_fe18bb475d6d40d988f6542074de4d67"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 30
    }

    data_disks = []
    extensions = []
  }
]

# ======================
# IDs
# ======================
vm_id = "/subscriptions/233e16db-2636-4f3c-8ae7-cdd9678d940b/resourceGroups/poc-hyc/providers/Microsoft.Compute/virtualMachines/poc-hyc"

network_interface_id = "/subscriptions/233e16db-2636-4f3c-8ae7-cdd9678d940b/resourceGroups/poc-hyc/providers/Microsoft.Network/networkInterfaces/poc-hyc542_z2"

# ======================
# Optional: Freshservice Integration
# ======================
# Uncomment and configure these values if using Freshservice alert integration
# function_app_name    = "hyc-func-alert-to-freshservice"
# storage_account_name = "hycfuncstorage01"
# freshservice_api_key = "YOUR_API_KEY"
# freshservice_domain  = "yourdomain.freshservice.com"

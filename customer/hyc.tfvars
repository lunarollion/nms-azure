# ======================
# Azure Authentication
# ======================
subscription_id = "0e1373c7-d99a-4eaa-9e16-59e648375f9e"
tenant_id       = "353846d6-a0d2-400e-8a7a-517a18e30c03"
client_id       = "19b97404-cd9c-4a64-afa9-855f7ae4ca2d"

# ======================
# Resource Group and Tags
# ======================
resource_group_name = "apac-es-devops-lunar-gultom"
location            = "eastus"

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
    location       = "eastus"
    resource_group = "poc-hyc"
    vm_size        = "Standard_B2als_v2"
    subnet_name    = "subnet1"
    os_disk = {
      name                 = "poc-hyc_OsDisk_1_8b1e2397ace54467b7e8cb99d3f58467"
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
vm_id = "/subscriptions/0e1373c7-d99a-4eaa-9e16-59e648375f9e/resourceGroups/apac-es-devops-lunar-gultom/providers/Microsoft.Compute/virtualMachines/poc-hyc"

network_interface_id = "/subscriptions/0e1373c7-d99a-4eaa-9e16-59e648375f9e/resourceGroups/apac-es-devops-lunar-gultom/providers/Microsoft.Network/networkInterfaces/poc-hyc464_z1"
# ======================
# Optional: Freshservice Integration
# ======================
# Uncomment and configure these values if using Freshservice alert integration
# function_app_name    = "hyc-func-alert-to-freshservice"
# storage_account_name = "hycfuncstorage01"
# freshservice_api_key = "YOUR_API_KEY"
# freshservice_domain  = "yourdomain.freshservice.com"

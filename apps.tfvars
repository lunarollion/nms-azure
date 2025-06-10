# Azure Auth
subscription_id     = "233e16db-2636-4f3c-8ae7-cdd9678d940b"
tenant_id           = "c2527675-3255-43a3-97c4-670a9c20d5c8"
client_id           = "9e9bbc03-edc2-493c-986d-610e52a70682"

# Azure Infra
resource_group_name = "apac-es-devops-lunar-gultom"
location            = "eastus"

tags = {
  environment = "poc"
  owner       = "poc-hyc"
  project     = "poc-monitoring"
}

# VNet
vnet_name          = "POC-HYC-vnet"
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

# VM Info
virtual_machines = [
  {
    name           = "POC-HYC"
    location       = "southeastasia" # Intentional region override
    resource_group = "apac-es-devops-lunar-gultom"
    vm_size        = "Standard_B2als_v2"
    subnet_name    = "subnet1"  # Changed from "default" to match defined subnets
    os_disk = {
      name                 = "POC-HYC_OsDisk_1_c412ca30dca8444b95bf4e51b880443e"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 30
    }
    data_disks  = []
    extensions  = []
  }
]

vm_id = "/subscriptions/0e1373c7-d99a-4eaa-9e16-59e648375f9e/resourceGroups/apac-es-devops-lunar-gultom/providers/Microsoft.Compute/virtualMachines/POC-HYC"

network_interface_id = "/subscriptions/0e1373c7-d99a-4eaa-9e16-59e648375f9e/resourceGroups/apac-es-devops-lunar-gultom/providers/Microsoft.Network/networkInterfaces/poc-hyc629_z1"

# Optional Freshservice integration variables (uncomment and fill if used)
# function_app_name     = "hyc-func-alert-to-freshservice"
# storage_account_name  = "hycfuncstorage01"
# freshservice_api_key  = "YOUR_API_KEY"
# freshservice_domain   = "yourdomain.freshservice.com"

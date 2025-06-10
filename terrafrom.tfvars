subscription_id   = "d68c21d0-1b10-408a-b2cb-8d7c4580a42c"
client_id         = "19b97404-cd9c-4a64-afa9-855f7ae4ca2d"
tenant_id         = "353846d6-a0d2-400e-8a7a-517a18e30c03"
resource_group_name = "apac-es-devops-lunar-gultom"
location            = "southeastasia"

tags = {
  environment = "poc"
  owner       = "poc-hyc"
  project     = "poc-monitoring"
}

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

virtual_machines = [
  {
    name           = "POC-HYC"
    location       = "southeastasia"
    resource_group = "apac-es-devops-lunar-gultom"
    vm_size        = "Standard_B2als_v2"
    subnet_name    = "default"
    os_disk = {
      name                 = "POC-HYC_OsDisk_1_c412ca30dca8444b95bf4e51b880443e"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 30
    }
    data_disks = []
    extensions = []
  }
]

vm_id = "/subscriptions/0e1373c7-d99a-4eaa-9e16-59e648375f9e/resourceGroups/apac-es-devops-lunar-gultom/providers/Microsoft.Compute/virtualMachines/POC-HYC"
network_interface_id = "/subscriptions/0e1373c7-d99a-4eaa-9e16-59e648375f9e/resourceGroups/apac-es-devops-lunar-gultom/providers/Microsoft.Network/networkInterfaces/poc-hyc629_z1"


# Your Function App and Freshservice variables (optional, if used later)
# function_app_name     = "hyc-func-alert-to-freshservice"
# storage_account_name  = "hycfuncstorage01"
# freshservice_api_key  = "YOUR_API_KEY"
# freshservice_domain   = "yourdomain.freshservice.com"

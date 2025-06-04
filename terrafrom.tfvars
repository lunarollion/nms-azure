subscription_id   = "d68c21d0-1b10-408a-b2cb-8d7c4580a42c"
client_id         = "YOUR_CLIENT_ID_HERE"
client_secret     = "YOUR_CLIENT_SECRET_HERE"
tenant_id         = "YOUR_TENANT_ID_HERE"

resource_group_name = "apac-es-devops-lunar-gultom"
location            = "southeastasia"

tags = {
  environment = "poc-test"
  owner       = "poc-hyc"
  project     = "windchill"
}

vnet_name          = "POC-HYC-vnet"
vnet_address_space = ["10.0.0.0/16"]

subnets = [
  {
    name           = "default"
    address_prefix = "10.0.0.0/24"
  },
  {
    name           = "default"
    address_prefix = "10.0.1.0/24"
  },
  {
    name           = "default"
    address_prefix = "10.0.2.0/24"
  }
]

virtual_machines = [
  {
    name           = "POC-HYC"
    location       = "southeastasia"
    resource_group = "apac-es-devops-lunar-gultom"
    vm_size        = "Standard_B2als_v2"
    admin_username = "adminpoc"
    admin_password = "Jakarta2025!"
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

# Your Function App and Freshservice variables (optional, if used later)
# function_app_name     = "hyc-func-alert-to-freshservice"
# storage_account_name  = "hycfuncstorage01"
# freshservice_api_key  = "YOUR_API_KEY"
# freshservice_domain   = "yourdomain.freshservice.com"

subscription_id   = "d68c21d0-1b10-408a-b2cb-8d7c4580a42c"
client_id         = "YOUR_CLIENT_ID_HERE"
client_secret     = "YOUR_CLIENT_SECRET_HERE"
tenant_id         = "YOUR_TENANT_ID_HERE"

resource_group_name = "hyc-windchill-prd-rg"
location            = "southeastasia"

tags = {
  environment = "production"
  owner       = "team-hyc"
  project     = "windchill"
}

vnet_name          = "hyc-windchill-prd-vnet"
vnet_address_space = ["172.20.0.0/24"]

subnets = [
  {
    name           = "AzureBastionSubnet"
    address_prefix = "172.20.0.192/26"
  },
  {
    name           = "apptier-prd-subnet"
    address_prefix = "172.20.0.0/25"
  },
  {
    name           = "dbtier-prd-subnet"
    address_prefix = "172.20.0.128/26"
  }
]

virtual_machines = [
  {
    name           = "vm-01"
    location       = "southeastasia"
    resource_group = "hyc-windchill-prd-rg"
    vm_size        = "Standard_B2s"
    admin_username = "azureuser"
    admin_password = "ComplexPasswordHere!"
    subnet_name    = "apptier-prd-subnet"
    os_disk = {
      name                 = "osdisk-vm-01"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }
    data_disks = []
    extensions = []
  }
]

# Your Function App and Freshservice variables
#function_app_name     = "hyc-func-alert-to-freshservice"
#storage_account_name  = "hycfuncstorage01"
#freshservice_api_key  = "YOUR_API_KEY"
#freshservice_domain   = "yourdomain.freshservice.com"

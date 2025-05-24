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
    name           = "apptier-prd-vm"
    location       = "southeastasia"
    resource_group = "hyc-windchill-prd-rg"
    vm_size        = "Standard_A8m_v2"
    admin_username = "hycadmin"
    subnet_name    = "apptier-prd-subnet"
    os_disk = {
      name                 = "apptier-prd-vm_OsDisk_1_b61e89de0307453e9848ef27a948a526"
      storage_account_type = "StandardSSD_LRS"
      disk_size_gb         = 127
    }
    data_disks = [
      {
        name                 = "apptier-prd-vm_DataDisk_0"
        lun                  = 0
        storage_account_type = "StandardSSD_LRS"
        disk_size_gb         = 250
      },
      {
        name                 = "apptier-prd-vm_DataDisk_1"
        lun                  = 2
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 1024
      }
    ]
    extensions = [
      {
        name                      = "AzureNetworkWatcherExtension"
        publisher                 = "Microsoft.Azure.NetworkWatcher"
        type                      = "NetworkWatcherAgentWindows"
        type_handler_version      = "1.4"
        auto_upgrade_minor_version = true
      }
    ]
  }
]

admin_password = "YourStrongP@ssw0rd!"

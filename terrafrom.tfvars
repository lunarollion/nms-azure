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

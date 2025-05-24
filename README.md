Azure Terraform Structure
├── main.tf           # Root main file, usually calls modules
├── variables.tf
├── providers.tf
├── terraform.tfvars        # <-- your variable values 
├── outputs.tf
├── modules/
│   ├── vm_module/
│   │    ├── main.tf           # VM + Networking resources
│   │    ├── variables.tf
│   │    └── outputs.tf
│   └── monitoring_module/
│        ├── main.tf           # Monitoring resources (Log Analytics, Diagnostic settings, alerts)
│        ├── variables.tf
│        └── outputs.tf


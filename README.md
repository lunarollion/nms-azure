root/
├── main.tf           # Root main file, usually calls modules
├── variables.tf
├── providers.tf
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
└── monitoring.tf      # Optional: You can put monitoring here if NOT using a separate module

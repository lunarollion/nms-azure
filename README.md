.
├── github/
│   └── workflows/
│       └── azure-deployment.yaml     # GitHub Actions workflow
├── main.tf                           # Root file calling all modules
├── providers.tf                      # Azure provider config (with backend if needed)
├── variables.tf                      # Input variable definitions
├── outputs.tf                        # Global outputs
├── customer/
│   ├── hyc.tfvars                    # Customer-specific variable values
│   └── stttelemedia.tfvars
├── modules/
│   ├── action_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── alert_vm/
│   │   ├── main.tf                   # VM metric alerts: CPU, memory, disk
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── alert_cdn/
│   │   ├── main.tf                   # CDN metric alerts: latency, 5xx, etc.
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── alert_dns/
│       ├── main.tf                   # DNS metric alerts: query failures, etc.
│       ├── variables.tf
│       └── outputs.tf

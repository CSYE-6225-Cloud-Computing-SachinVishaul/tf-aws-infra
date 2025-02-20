# tf-aws-infra

Terraform repository for AWS infrastructure deployment (CSYE6225). Uses modular design for reproducibility, scalability, and AWS best practices.

## Overview

Core components:
- VPC and Networking: Custom VPCs, public/private subnets, routing tables, internet gateways
- Compute Resources: EC2 instances and services
- Security: Security groups, IAM roles, policies  
- State Management: AWS S3 remote state, DynamoDB state locking

## Repository Structure
tf-aws-infra/
├── modules/               # Reusable Terraform modules
│   ├── vpc/              # VPC configurations
│   ├── ec2/              # EC2 configurations
│   └── security/         # Security configs
├── environments/         # Environment configs
│   ├── dev/
│   └── prod/
├── main.tf              # Main configuration
├── variables.tf         # Variables
├── outputs.tf           # Outputs
├── terraform.tfvars     # Variable values
└── README.md

## Prerequisites

- Terraform v1.0+
- Configured AWS CLI
- AWS Account permissions (VPC, EC2, S3, DynamoDB)

## Getting Started

1. Clone repository:
```bash
git clone https://github.com/yourusername/tf-aws-infra.git
cd tf-aws-infra
```

2. Initialize Terraform:
```bash
bashCopyterraform init
```

3. Configure variables in terraform.tfvars:
```bash
hclCopyaws_region = "us-east-1"
environment = "dev"
```

4. Plan and apply:
```bash
bashCopyterraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## Testing and Validation
```bash
terraform validate
terraform plan
```
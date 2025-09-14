# VPC Lattice Terraform Infrastructure

This directory contains Terraform modules and configurations for demonstrating AWS VPC Lattice service-to-service communication.

## 📁 Directory Structure

```plaintext
terraform/
├── main.tf                 # Root Terraform configuration
├── outputs.tf             # Root module outputs
├── local.tf               # Local values and data sources
├── versions.tf            # Terraform and provider version constraints
└── modules/
    ├── vpc/               # VPC module (3 VPCs: client, app1, app2)
    ├── ec2/               # EC2 notifications service
    ├── ec2_web_server/    # EC2 web server for VPC Lattice demo
    ├── ecs_fargate/       # ECS Fargate analytics service
    ├── lambda/            # Lambda functions
    └── vpc_lattice/       # VPC Lattice service network and services
```

## 🚀 Quick Start

1. **Initialize Terraform**

   ```bash
   cd terraform
   terraform init
   ```

2. **Review the configuration**

   ```bash
   terraform plan
   ```

3. **Deploy the infrastructure**

   ```bash
   terraform apply
   ```

## 🏗️ Architecture Overview

This Terraform configuration creates a complete VPC Lattice demonstration environment:

- **3 VPCs**: Client, App1, and App2 VPCs for multi-VPC communication
- **EC2 Instances**: Web servers and notification services
- **ECS Fargate**: Containerized analytics service
- **VPC Lattice**: Service network connecting all services
- **Lambda Functions**: Serverless components

## 📋 Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform >= 1.0
- AWS Provider >= 5.0

## 🔧 Configuration

The main configuration file (`main.tf`) orchestrates all modules and creates the complete VPC Lattice environment.

## 📊 Outputs

After deployment, you'll get:

- VPC IDs and CIDR blocks
- EC2 instance details
- ECS service endpoints
- VPC Lattice service network information

## 🧹 Cleanup

To destroy all resources:

```bash
terraform destroy
```

## 📚 Learn More

- [AWS VPC Lattice Documentation](https://docs.aws.amazon.com/vpc-lattice/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

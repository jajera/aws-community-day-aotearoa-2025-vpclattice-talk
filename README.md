# VPC Lattice: Modern Service Networking

> **AWS Community Day Aotearoa 2025**
> A comprehensive resource for learning about AWS VPC Lattice and implementing modern service-to-service communication patterns.

## 🎯 Abstract

This repository contains everything you need for the "VPC Lattice: Modern Service Networking" session at AWS Community Day Aotearoa 2025. Learn how VPC Lattice revolutionizes service networking by providing a unified way to connect, secure, and monitor traffic between your services across VPCs, accounts, and regions.

**What you'll learn:**

- Core VPC Lattice concepts and architecture
- When to use VPC Lattice vs. other networking solutions
- Hands-on implementation with Terraform
- Security best practices for service networking
- Real-world use cases and patterns

## 📁 Repository Structure

```plaintext
aws-community-day-aotearoa-2025-vpclattice-talk/
├── .github/workflows/          # CI/CD pipelines
├── docs/                       # Static website source
│   ├── index.html             # Landing page
│   ├── agenda.html            # Session outline
│   ├── resources.html         # Links and references
│   ├── terraform.html         # Terraform documentation
│   ├── css/                   # Styling
│   ├── img/                   # Images
│   └── slides/                # Presentation materials
│       └── awscd-aotearoa-vpc-lattice-talk.pptx
├── slides/                     # Original presentation materials
│   └── awscd-aotearoa-vpc-lattice-talk.pptx  # PowerPoint deck
└── terraform/                  # Infrastructure as Code
    ├── main.tf                # Main Terraform configuration
    ├── local.tf               # Local values
    ├── outputs.tf             # Output definitions
    ├── versions.tf            # Provider versions
    └── modules/               # Reusable Terraform modules
        ├── vpc_lattice/       # VPC Lattice module
        ├── vpc/               # VPC module
        ├── ec2/               # EC2 module
        ├── ec2_web_server/    # Web server module
        ├── ecs_fargate/       # ECS Fargate module
        └── lambda/            # Lambda module
```

## 🎤 Slides & Presentation

### Primary Materials

- **[PowerPoint Deck](docs/slides/awscd-aotearoa-vpc-lattice-talk.pptx)** - Main presentation file (accessible via website)
- **[Original Source](slides/awscd-aotearoa-vpc-lattice-talk.pptx)** - Source PowerPoint file

### How to View

1. **Download**: Click the "Download Slides" button on the website
2. **PowerPoint**: Open in PowerPoint/Office 365
3. **Online**: Visit the [live website](#-live-website) for direct access

## 🌐 Live Website

The static website is automatically deployed to GitHub Pages and includes:

- **Session overview** and speaker information
- **Interactive agenda** with learning outcomes
- **Comprehensive resources** and references
- **Terraform documentation** and examples
- **Direct links** to slides and code examples

**🔗 [View Live Website](https://jajera.github.io/aws-community-day-aotearoa-2025-vpclattice-talk/)**

## 🏗️ Terraform Example

### What It Demonstrates

The Terraform configuration shows how to:

- Create a VPC Lattice service network
- Associate VPCs with the service network
- Set up target groups and services
- Configure listeners and routing
- Apply security best practices
- Deploy various service types (EC2, ECS, Lambda)

### Prerequisites

- **AWS CLI** configured with credentials
- **Terraform** >= 1.6.0
- **Existing VPC** with private subnets
- **IAM permissions** for VPC Lattice resources

### Quick Start

```bash
# Navigate to the terraform directory
cd terraform

# Initialize Terraform
terraform init

# Review the configuration
terraform plan

# Apply (when ready)
terraform apply
```

### Safety Features

- **Modular design** - reusable components
- **Clear documentation** - each module has its own README
- **Cost warnings** - clear documentation of potential costs
- **Easy cleanup** - simple `terraform destroy` command

### Full Documentation

See [terraform/README.md](terraform/README.md) for complete setup instructions, troubleshooting, and best practices.

## 🚀 Getting Started

### For Attendees

1. **Clone the repository**:

   ```bash
   git clone https://github.com/jajera/aws-community-day-aotearoa-2025-vpclattice-talk.git
   cd aws-community-day-aotearoa-2025-vpclattice-talk
   ```

2. **View the slides**:
   - Visit the live website and click "Download Slides"
   - Or open `docs/slides/awscd-aotearoa-vpc-lattice-talk.pptx` directly

3. **Try the Terraform example**:

   ```bash
   cd terraform
   # Follow the README.md instructions
   ```

4. **Explore the website**:
   - Open `docs/index.html` in your browser
   - Or visit the live GitHub Pages site

### For Developers

1. **Serve locally for development**:

   ```bash
   cd docs
   python -m http.server 8000
   # Visit http://localhost:8000
   ```

2. **Validate Terraform**:

   ```bash
   cd terraform
   terraform validate
   terraform plan
   ```

## 🛠️ Development

### Available Commands

```bash
# Serve website locally
cd docs && python -m http.server 8000

# Validate Terraform
cd terraform && terraform validate

# Format Terraform files
cd terraform && terraform fmt

# Plan Terraform changes
cd terraform && terraform plan
```

### CI/CD Pipeline

The repository includes GitHub Actions workflows:

- **`pages.yml`**: Deploys the website to GitHub Pages on main branch

### Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally
5. Submit a pull request

## 📚 Resources & References

### Official AWS Documentation

- [VPC Lattice User Guide](https://docs.aws.amazon.com/vpc-lattice/)
- [API Reference](https://docs.aws.amazon.com/vpc-lattice/latest/APIReference/)
- [Pricing Information](https://aws.amazon.com/vpc/pricing/)

### Learning Materials

- [AWS Training](https://aws.amazon.com/training/)
- [AWS Workshops](https://workshops.aws/)
- [AWS re:Post Community](https://repost.aws/)

### Tools & Utilities

- [AWS CLI](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/vpc-lattice/)
- [Terraform Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpclattice_service_network)
- [AWS Console](https://console.aws.amazon.com/vpc-lattice/)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Standards

- **Terraform**: Use `terraform fmt` and `terraform validate`
- **HTML/CSS**: Follow modern web standards
- **Commits**: Use conventional commit messages
- **Testing**: All changes must work locally

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- AWS Community Day Aotearoa 2025 organizers
- AWS VPC Lattice team for the excellent service
- The open-source community for tools and inspiration

## 📞 Contact & Support

- **GitHub Issues**: [Open an issue](https://github.com/jajera/aws-community-day-aotearoa-2025-vpclattice-talk/issues)
- **LinkedIn**: [John Ajera Profile](https://linkedin.com/in/john-ajera)

---

Made with ❤️ for the AWS Community in Aotearoa New Zealand

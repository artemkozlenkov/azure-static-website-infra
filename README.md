# Personal Website Infrastructure

This project contains the Terraform infrastructure code and website files for deploying and managing a personal website.

## Project Structure

- `main.tf`, `provider.tf`, `variables.tf`, `terraform.tfvars`: Root Terraform configuration files.
- `modules/`: Contains reusable Terraform modules.
  - `storage_account/`: Terraform module for provisioning Azure Storage Account resources.
- `website/`: Contains static website files (e.g., `index.html`).

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed (version compatible with the configuration).
- Azure CLI installed and authenticated (`az login`).
- An Azure subscription with permissions to create resources.

## Quick Start

1. **Initialize Terraform**

   ```bash
   terraform init
   ```

2. **Review Terraform Plan**

   ```bash
   terraform plan -var-file="terraform.tfvars"
   ```

3. **Apply Terraform Configuration**

   ```bash
   terraform apply -var-file="terraform.tfvars"
   ```

   This will provision the infrastructure resources defined in the Terraform configuration.

4. **Access the Website**

   After deployment, the website content in `website/` will be hosted (e.g., in an Azure Storage Account static website or other configured service).

## Notes

- Terraform state files (`*.tfstate`) are ignored by `.gitignore` to prevent sensitive data leakage.
- Customize variables in `terraform.tfvars` as needed for your environment.
- Use the modules in `modules/` to extend or modify infrastructure components.

## License

This project is licensed under the MIT License.
# Personal Website Infrastructure

This project contains the Terraform infrastructure code and website files for deploying and managing a personal website.

## Project Structure

- `main.tf`, `provider.tf`, `variables.tf`, `terraform.tfvars`: Root Terraform configuration files.
- `modules/`: Contains reusable Terraform modules.
  - `storage_account/`: Terraform module for provisioning Azure Storage Account resources.
- `website/`: Contains static website files (e.g., `index.html`).
- `run.sh`: Script to manage Terraform deployment lifecycle, run Gitleaks, and pre-commit-terraform.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed (version compatible with the configuration).
- Docker installed and running.
- Azure CLI installed and authenticated (`az login`).
- An initialized Git repository for pre-commit hooks to work correctly.

## Quick Start

This project includes a helper script `run.sh` to simplify common tasks.

Make sure the script is executable:

```bash
chmod +x run.sh
```

### Usage

Run the following commands as needed:

- **Deploy infrastructure:**

  Runs `terraform init`, `validate`, `plan`, and `apply` to deploy the infrastructure.

  ```bash
  ./run.sh deploy
  ```

- **Teardown infrastructure:**

  Runs `terraform destroy` to remove all deployed resources.

  ```bash
  ./run.sh teardown
  ```

- **Run Gitleaks:**

  Scans the codebase for secrets and sensitive information.

  ```bash
  ./run.sh gitleaks
  ```

- **Run pre-commit-terraform:**

  Executes pre-commit hooks related to Terraform formatting, validation, linting, and documentation.

  ```bash
  ./run.sh pre-commit-terraform
  ```

## Notes

- The helper script ensures Terraform lifecycle commands are executed with proper error handling.
- The repository must be initialized as a Git repository for pre-commit hooks to function.
- Customize variables in `terraform.tfvars` as needed for your environment.
- Terraform state files (`*.tfstate`) are ignored by `.gitignore` to prevent sensitive data leakage.
- Use the modules in `modules/` to extend or modify infrastructure components.

## License

This project is licensed under the MIT License.
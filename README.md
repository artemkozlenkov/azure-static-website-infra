# Personal Website Infrastructure

This project contains the Terraform infrastructure code and website files for deploying and managing a personal website.

## Project Structure

- `main.tf`, `provider.tf`, `variables.tf`, `terraform.tfvars`: Root Terraform configuration files.
- `modules/`: Contains reusable Terraform modules.
  - `storage_account/`: Terraform module for provisioning Azure Storage Account resources.
- `website/`: Contains static website files (e.g., `index.html`).
- `run.sh`: Script to manage Terraform deployment lifecycle, run Gitleaks, and pre-commit-terraform.
- `.pre-commit-config.yaml`: Configuration for pre-commit hooks to enforce code quality and standards.

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

  Executes pre-commit hooks related to Terraform to ensure code quality and consistency.

  ```bash
  ./run.sh pre-commit-terraform
  ```

## Pre-commit Terraform Checks

The `.pre-commit-config.yaml` file configures the following checks on Terraform files (`*.tf` and `*.tfvars`):

- **terraform_fmt:** Ensures that Terraform files are properly formatted according to `terraform fmt`. It checks for formatting issues and fails if files are not formatted correctly.

- **terraform_validate:** Validates the Terraform configuration to catch syntax errors or invalid configurations early.

- **terraform_tflint:** Runs `tflint` to detect potential issues, best practice violations, and missing version constraints such as `required_version` and `required_providers`. It also detects unused variables and other linting warnings.

- **terraform_docs:** Automatically generates and updates Terraform module documentation based on the current configuration.

These checks help maintain code quality, consistency, and adherence to Terraform best practices before changes are committed.

## Notes

- The helper script ensures Terraform lifecycle commands are executed with proper error handling.
- The repository must be initialized as a Git repository for pre-commit hooks to function.
- Customize variables in `terraform.tfvars` as needed for your environment.
- Terraform state files (`*.tfstate`) are ignored by `.gitignore` to prevent sensitive data leakage.
- Use the modules in `modules/` to extend or modify infrastructure components.

## License

This project is licensed under the MIT License.
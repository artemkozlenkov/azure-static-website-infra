#!/bin/bash

# Script to manage Terraform deployment lifecycle, run Gitleaks, and pre-commit-terraform.

# Define the pre-commit-terraform image tag
PRE_COMMIT_TERRAFORM_TAG="latest"  # Make this configurable if needed

# Define the Terraform working directory
TERRAFORM_DIR="."

# Function to check if Terraform is installed
check_terraform() {
  if ! command -v terraform &> /dev/null; then
    echo "Error: terraform is not installed."
    echo "Please install Terraform before running this script."
    exit 1
  fi
}

# Function to run Terraform init, validate, plan and apply for deployment lifecycle
terraform_apply() {
  echo "Running Terraform deployment lifecycle..."
  pushd "$TERRAFORM_DIR" >/dev/null || return 1

  terraform init
  if [ $? -ne 0 ]; then
    echo "Terraform init failed."
    popd >/dev/null
    return 1
  fi

  terraform validate
  if [ $? -ne 0 ]; then
    echo "Terraform validate failed."
    popd >/dev/null
    return 1
  fi

  terraform plan -out=tfplan
  if [ $? -ne 0 ]; then
    echo "Terraform plan failed."
    popd >/dev/null
    return 1
  fi

  terraform apply -auto-approve tfplan
  if [ $? -ne 0 ]; then
    echo "Terraform apply failed."
    popd >/dev/null
    return 1
  fi

  popd >/dev/null
  echo "Terraform deployment completed successfully."
  return 0
}

# Function to run Terraform destroy for teardown lifecycle
terraform_destroy() {
  echo "Running Terraform destroy lifecycle..."
  pushd "$TERRAFORM_DIR" >/dev/null || return 1

  terraform destroy -auto-approve
  if [ $? -ne 0 ]; then
    echo "Terraform destroy failed."
    popd >/dev/null
    return 1
  fi

  popd >/dev/null
  echo "Terraform destroy completed successfully."
  return 0
}

# Function to deploy (terraform apply)
deploy() {
  check_terraform
  terraform_apply || { echo "Terraform deployment failed."; return 1; }
}

# Function to teardown (terraform destroy)
teardown() {
  check_terraform
  terraform_destroy || { echo "Terraform destroy failed."; return 1; }
}

# Function to run Gitleaks
run_gitleaks() {
  echo "Running Gitleaks..."
  if docker run --rm -v "$(pwd):/app" -w /app zricethezav/gitleaks git -v; then
    echo "Gitleaks scan completed."
  else
    echo "Gitleaks scan failed."
    return 1
  fi
}

# Function to run pre-commit-terraform
run_pre_commit_terraform() {
  echo "Running pre-commit-terraform..."
  USERID=$(id -u):$(id -g)
  if docker run --rm -e "USERID=$USERID" -v "$(pwd):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform:"$PRE_COMMIT_TERRAFORM_TAG" run -a; then
    echo "pre-commit-terraform completed."
  else
    echo "pre-commit-terraform failed."
    return 1
  fi
}

# Function to display usage instructions
usage() {
  echo "Usage: $0 {deploy|teardown|gitleaks|pre-commit-terraform}"
  echo "  deploy               : Runs terraform apply lifecycle."
  echo "  teardown             : Runs terraform destroy lifecycle."
  echo "  gitleaks             : Runs Gitleaks to scan for secrets."
  echo "  pre-commit-terraform : Runs pre-commit-terraform."
  exit 1
}

# --- Main Script ---

# Check for command-line arguments
if [ "$#" -eq 0 ]; then
    usage
fi

case "$1" in
    deploy)
        deploy
        ;;
    teardown)
        teardown
        ;;
    gitleaks)
        run_gitleaks
        ;;
    pre-commit-terraform)
        run_pre_commit_terraform
        ;;
    *)
        echo "Invalid argument: $1"
        usage
        ;;
esac

exit $?
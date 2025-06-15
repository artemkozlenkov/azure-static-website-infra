terraform {
  required_version = ">= 1.3.0"

  backend "local" {}

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.16.0"

    }
  }
}

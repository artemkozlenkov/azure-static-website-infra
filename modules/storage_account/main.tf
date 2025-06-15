terraform {
  required_version = ">= 1.3.0"
}

variable "storage_account_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "container_name" {
  type = string
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  cross_tenant_replication_enabled = true

  static_website {
    index_document = "index.html"
    error_404_document = "404.html"
  }
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "this" {
  name                   = var.blob_name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.container_name
  type                   = "Block"
  source                 = var.blob_source
  content_type           = var.blob_content_type

  depends_on = [
    azurerm_storage_account.storage
  ]
}
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "storage_account" {
  source              = "./modules/storage_account"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  storage_account_name = "hugocoderstorage"
  container_name       = "$web"

  blob_name            = "index.html"
  blob_source          = "./website/index.html"
  blob_content_type    = "text/html"
}

resource "azurerm_dns_cname_record" "personal_static_website" {
  name                = "personal"
  zone_name           = "softawebit.com"
  resource_group_name = "rg-main"
  ttl                 = 3600
  record              = "hugocoderstorage.z6.web.core.windows.net"
}

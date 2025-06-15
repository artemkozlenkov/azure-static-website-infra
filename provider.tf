provider "azurerm" {
  features {
  }
  use_oidc                        = false
  resource_provider_registrations = "none"
  subscription_id                 = "d597c780-08e7-4409-9b46-ea9f2afc1e1a"
  environment                     = "public"
  use_msi                         = false
  use_cli                         = true
}

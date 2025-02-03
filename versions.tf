terraform {
  required_providers {
    azurerm = {

    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  use_oidc        = true
  features {

  }
}
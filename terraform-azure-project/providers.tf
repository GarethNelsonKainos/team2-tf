terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstatedavidohanlon"
    container_name       = "tfstate"
    use_azuread_auth     = true
    # key is passed at init time via -backend-config
  }
}

provider "azurerm" {
  features {}
}
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstateblitzcrank"
    storage_account_name = "tfstateblitzcrank29242"
    container_name       = "tfstateteam2sam"
    key                  = "team2.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

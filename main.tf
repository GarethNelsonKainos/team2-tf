terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev-nick"
    storage_account_name = "sttfstatenick"
    container_name       = "tfstate"
    key                  = "team2.tfstate"
  }
}

provider "azurerm" {
  features {}
}

locals {
  normalized_environment = lower(var.environment)
  normalized_project     = replace(replace(replace(replace(lower(var.project_name), "-", ""), "_", ""), ".", ""), " ", "")
  storage_name_base      = "${local.normalized_project}${local.normalized_environment}${var.instance_number}"
  computed_rg_name       = "rg-${var.project_name}-${local.normalized_environment}-${var.instance_number}"
  effective_rg_name      = coalesce(var.resource_group_name, local.computed_rg_name)
}

module "resource_group" {
  source = "./modules/resource-group"

  name     = local.effective_rg_name
  location = var.location
}
terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {
  normalized_environment = lower(var.environment)
  computed_rg_name       = "rg-${var.project_name}-${local.normalized_environment}-${var.instance_number}"
  effective_rg_name      = coalesce(var.resource_group_name, local.computed_rg_name)
}

module "resource_group" {
  source = "./modules/resource-group"

  name     = local.effective_rg_name
  location = var.location
}
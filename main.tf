terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

moved {
  from = azurerm_resource_group.rg
  to   = module.resource_group.azurerm_resource_group.this
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
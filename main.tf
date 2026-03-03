terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

resource "random_string" "storage_suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_storage_account" "sa" {
  name                     = "st${substr(local.storage_name_base, 0, 16)}${random_string.storage_suffix.result}"
  location                 = var.location
  resource_group_name      = module.resource_group.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

moved {
  from = azurerm_resource_group.rg
  to   = module.resource_group.azurerm_resource_group.this
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
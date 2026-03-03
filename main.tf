provider "azurerm" {
  features {}
}

locals {
  normalized_environment = lower(var.environment)
  computed_rg_name       = "rg-${var.project_name}-${local.normalized_environment}-${var.instance_number}"
  effective_rg_name      = coalesce(var.resource_group_name, local.computed_rg_name)

  common_tags = merge(
    {
      environment = local.normalized_environment
      project     = var.project_name
      managed_by  = "terraform"
    },
    var.tags
  )
}

resource "azurerm_resource_group" "rg" {
  name     = local.effective_rg_name
  location = var.location
  tags     = local.common_tags
}
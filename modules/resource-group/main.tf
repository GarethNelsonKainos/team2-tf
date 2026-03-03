# Simple Resource Group Module
# Following Azure best practices for Terraform modules

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

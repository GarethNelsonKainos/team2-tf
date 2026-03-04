resource "azurerm_resource_group" "prod" {
  name     = "prod-resource-group"
  location = "East US"
}

module "azure_resources" {
  source              = "../../modules/azure"
  resource_group_name = azurerm_resource_group.prod.name
  location            = azurerm_resource_group.prod.location
}

output "resource_group_id" {
  value = azurerm_resource_group.prod.id
}
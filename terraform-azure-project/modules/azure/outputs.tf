# terraform-azure-project/modules/azure/outputs.tf

output "resource_id" {
  value = azurerm_resource_group.main.id
}

output "resource_name" {
  value = azurerm_resource_group.main.name
}

output "location" {
  value = azurerm_resource_group.main.location
}
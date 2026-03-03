output "resource_group_name" {
  description = "The name of the Azure resource group"
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "The ID of the Azure resource group"
  value       = azurerm_resource_group.this.id
}

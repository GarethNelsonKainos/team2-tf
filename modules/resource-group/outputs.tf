# Module Outputs - expose key resource attributes

output "name" {
  description = "The name of the created resource group."
  value       = azurerm_resource_group.rg.name
}

output "id" {
  description = "The ID of the created resource group."
  value       = azurerm_resource_group.rg.id
}

output "location" {
  description = "The location of the resource group."
  value       = azurerm_resource_group.rg.location
}

output "resource" {
  description = "The entire resource group resource object."
  value       = azurerm_resource_group.rg
}

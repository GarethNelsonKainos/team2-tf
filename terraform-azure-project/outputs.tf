# terraform-azure-project/outputs.tf

output "resource_group_name" {
  description = "The name of the deployed resource group"
  value       = module.resource_group.name
}

output "resource_id" {
  description = "The Azure Resource ID of the resource group"
  value       = module.resource_group.id
}

output "location" {
  description = "The Azure region the resource group was deployed to"
  value       = module.resource_group.location
}
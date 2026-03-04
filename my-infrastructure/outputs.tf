output "resource_group_name" {
  description = "Resource group name."
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "Resource group ID."
  value       = module.resource_group.id
}

output "resource_group_location" {
  description = "Resource group location."
  value       = module.resource_group.location
}

output "key_vault_name" {
  description = "Azure Key Vault name."
  value       = azurerm_key_vault.main.name
}

output "key_vault_id" {
  description = "Azure Key Vault resource ID."
  value       = azurerm_key_vault.main.id
}

output "key_vault_uri" {
  description = "Azure Key Vault URI for secret references."
  value       = azurerm_key_vault.main.vault_uri
}

output "container_apps_identity_id" {
  description = "User Assigned Managed Identity resource ID for Container Apps."
  value       = azurerm_user_assigned_identity.container_apps.id
}

output "container_apps_identity_principal_id" {
  description = "User Assigned Managed Identity principal ID for RBAC role assignments."
  value       = azurerm_user_assigned_identity.container_apps.principal_id
}

output "container_apps_identity_client_id" {
  description = "User Assigned Managed Identity client ID."
  value       = azurerm_user_assigned_identity.container_apps.client_id
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID."
  value       = azurerm_log_analytics_workspace.main.id
}

output "container_app_environment_id" {
  description = "Container App Environment resource ID."
  value       = azurerm_container_app_environment.main.id
}

output "container_app_environment_default_domain" {
  description = "Container App Environment default domain for app URLs."
  value       = azurerm_container_app_environment.main.default_domain
}

output "acr_login_server" {
  description = "Azure Container Registry login server URL."
  value       = data.azurerm_container_registry.main.login_server
}

output "acr_id" {
  description = "Azure Container Registry resource ID."
  value       = data.azurerm_container_registry.main.id
}

output "acr_image1" {
  description = "Fully qualified ACR image 1 reference."
  value       = "${var.acr_image1_repo}:${var.acr_image1_tag}"
}

output "acr_image2" {
  description = "Fully qualified ACR image 2 reference."
  value       = "${var.acr_image2_repo}:${var.acr_image2_tag}"
}

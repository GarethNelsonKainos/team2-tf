# Container App Module Outputs

output "id" {
  description = "Container App resource ID."
  value       = azurerm_container_app.app.id
}

output "name" {
  description = "Container App name."
  value       = azurerm_container_app.app.name
}

output "fqdn" {
  description = "Fully qualified domain name (FQDN) of the container app ingress, if enabled."
  value       = var.enable_ingress ? azurerm_container_app.app.latest_revision_fqdn : null
}

output "latest_revision_name" {
  description = "Latest revision name."
  value       = azurerm_container_app.app.latest_revision_name
}

output "outbound_ip_addresses" {
  description = "Outbound IP addresses used by the container app."
  value       = azurerm_container_app.app.outbound_ip_addresses
}

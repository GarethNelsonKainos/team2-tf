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

output "acr_image1" {
  description = "Fully qualified ACR image 1 reference."
  value       = "${var.acr_image1_repo}:${var.acr_image1_tag}"
}

output "acr_image2" {
  description = "Fully qualified ACR image 2 reference."
  value       = "${var.acr_image2_repo}:${var.acr_image2_tag}"
}

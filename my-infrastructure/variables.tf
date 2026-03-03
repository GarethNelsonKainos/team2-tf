variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
  default     = "rg-team2-dev"

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = "resource_group_name must not be empty."
  }
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "uksouth"
}

variable "environment" {
  description = "Deployment environment (dev, test, prod)."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, prod."
  }
}

variable "acr_image1_repo" {
  description = "ACR image 1 repository (include registry server, e.g. myregistry.azurecr.io/app)."
  type        = string
  default     = "myregistry.azurecr.io/app1"

  validation {
    condition     = length(trimspace(var.acr_image1_repo)) > 0
    error_message = "acr_image1_repo must not be empty."
  }
}

variable "acr_image1_tag" {
  description = "ACR image 1 tag."
  type        = string
  default     = "latest"

  validation {
    condition     = length(trimspace(var.acr_image1_tag)) > 0
    error_message = "acr_image1_tag must not be empty."
  }
}

variable "acr_image2_repo" {
  description = "ACR image 2 repository (include registry server, e.g. myregistry.azurecr.io/app)."
  type        = string
  default     = "myregistry.azurecr.io/app2"

  validation {
    condition     = length(trimspace(var.acr_image2_repo)) > 0
    error_message = "acr_image2_repo must not be empty."
  }
}

variable "acr_image2_tag" {
  description = "ACR image 2 tag."
  type        = string
  default     = "latest"

  validation {
    condition     = length(trimspace(var.acr_image2_tag)) > 0
    error_message = "acr_image2_tag must not be empty."
  }
}

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

variable "key_vault_name" {
  description = "Globally unique Azure Key Vault name (3-24 lowercase letters/numbers)."
  type        = string
  default     = "kvteam2devsam20260304"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.key_vault_name))
    error_message = "key_vault_name must be 3-24 chars, lowercase letters and numbers only."
  }
}

variable "acr_name" {
  description = "Existing Azure Container Registry name."
  type        = string
  default     = "academyacrj3r5dv"

  validation {
    condition     = length(trimspace(var.acr_name)) > 0
    error_message = "acr_name must not be empty."
  }
}

variable "acr_resource_group_name" {
  description = "Resource group containing the existing Azure Container Registry."
  type        = string
  default     = "rg-academy-acr"

  validation {
    condition     = length(trimspace(var.acr_resource_group_name)) > 0
    error_message = "acr_resource_group_name must not be empty."
  }
}

variable "container_apps_identity_name" {
  description = "User Assigned Managed Identity name used by Container Apps for ACR and Key Vault access."
  type        = string
  default     = "id-team2-ca-dev"

  validation {
    condition     = length(trimspace(var.container_apps_identity_name)) > 0
    error_message = "container_apps_identity_name must not be empty."
  }
}

variable "log_analytics_workspace_name" {
  description = "Log Analytics workspace name for Container Apps environment logging."
  type        = string
  default     = "log-team2-ca-dev"

  validation {
    condition     = length(trimspace(var.log_analytics_workspace_name)) > 0
    error_message = "log_analytics_workspace_name must not be empty."
  }
}

variable "container_app_environment_name" {
  description = "Container App Environment name."
  type        = string
  default     = "cae-team2-dev"

  validation {
    condition     = length(trimspace(var.container_app_environment_name)) > 0
    error_message = "container_app_environment_name must not be empty."
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

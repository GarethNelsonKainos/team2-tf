# Container App Module Variables

variable "name" {
  description = "Container App name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where the Container App will be created."
  type        = string
}

variable "container_app_environment_id" {
  description = "Container App Environment resource ID."
  type        = string
}

variable "managed_identity_id" {
  description = "User Assigned Managed Identity resource ID for registry and Key Vault access."
  type        = string
}

variable "revision_mode" {
  description = "Revision mode: Single or Multiple."
  type        = string
  default     = "Single"
}

variable "registry_server" {
  description = "Container registry server (e.g., myregistry.azurecr.io)."
  type        = string
}

variable "container_name" {
  description = "Name of the container within the app."
  type        = string
}

variable "image_repo" {
  description = "Full container image repository path (e.g., myregistry.azurecr.io/app)."
  type        = string
}

variable "image_tag" {
  description = "Container image tag."
  type        = string
  default     = "latest"
}

variable "cpu" {
  description = "vCPU allocation for the container (e.g., 0.25, 0.5, 1.0)."
  type        = number
  default     = 0.5
}

variable "memory" {
  description = "Memory allocation for the container (e.g., 0.5Gi, 1Gi)."
  type        = string
  default     = "1Gi"
}

variable "min_replicas" {
  description = "Minimum number of replicas."
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Maximum number of replicas."
  type        = number
  default     = 10
}

variable "enable_ingress" {
  description = "Enable HTTP ingress for this container app."
  type        = bool
  default     = true
}

variable "external_enabled" {
  description = "Allow external (public) ingress. Set false for internal-only access."
  type        = bool
  default     = false
}

variable "target_port" {
  description = "Container port for ingress traffic."
  type        = number
  default     = 80
}

variable "env_vars" {
  description = "List of environment variables (plain text, for feature flags etc)."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "secret_env_vars" {
  description = "List of environment variables sourced from Container App secrets."
  type = list(object({
    name        = string
    secret_name = string
  }))
  default = []
}

variable "keyvault_secrets" {
  description = "List of Key Vault secret references to expose as Container App secrets."
  type = list(object({
    name                = string
    key_vault_secret_id = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to assign to the Container App."
  type        = map(string)
  default     = {}
}

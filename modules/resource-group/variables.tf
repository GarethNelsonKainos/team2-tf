variable "name" {
  description = "The name of the Azure resource group."
  type        = string

  validation {
    condition = (
      length(var.name) >= 1 &&
      length(var.name) <= 90 &&
      can(regex("^[a-zA-Z0-9._()\\-]+$", var.name))
    )
    error_message = "name must be 1-90 chars and only contain letters, numbers, '.', '_', '-', or parentheses."
  }
}

variable "location" {
  description = "Azure region where the resource group is deployed."
  type        = string

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "location must not be empty."
  }
}

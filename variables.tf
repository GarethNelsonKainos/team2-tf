variable "resource_group_name" {
	description = "Optional explicit resource group name. If null, the name is generated from project_name, environment, and instance_number."
	type        = string
	default     = null
	nullable    = true

	validation {
		condition = var.resource_group_name == null || (
			length(var.resource_group_name) >= 1 &&
			length(var.resource_group_name) <= 90 &&
			can(regex("^[a-zA-Z0-9._()\\-]+$", var.resource_group_name))
		)
		error_message = "resource_group_name must be 1-90 chars and only contain letters, numbers, '.', '_', '-', or parentheses."
	}
}

variable "location" {
	description = "Azure region where resources are deployed."
	type        = string
	default     = "uksouth"

	validation {
		condition     = length(trimspace(var.location)) > 0
		error_message = "location must not be empty."
	}
}

variable "environment" {
	description = "Deployment environment. Allowed values: dev, test, prod."
	type        = string
	default     = "dev"

	validation {
		condition     = contains(["dev", "test", "prod"], lower(var.environment))
		error_message = "environment must be one of: dev, test, prod."
	}
}

variable "project_name" {
	description = "Short project/application identifier used in generated resource names."
	type        = string
	default     = "demo"

	validation {
		condition     = length(trimspace(var.project_name)) > 0
		error_message = "project_name must not be empty."
	}
}

variable "instance_number" {
	description = "Three-digit instance suffix used in generated naming (for example: 001, 002)."
	type        = string
	default     = "001"

	validation {
		condition     = can(regex("^[0-9]{3}$", var.instance_number))
		error_message = "instance_number must be exactly 3 digits (for example: 001)."
	}
}

variable "tags" {
	description = "Additional tags to apply to all resources."
	type        = map(string)
	default     = {}
}

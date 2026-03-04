variable "name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the resource group into"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the resource group"
  type        = map(string)
  default     = {}
}
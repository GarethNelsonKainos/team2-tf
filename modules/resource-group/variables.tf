# Input Variables - following Azure Verified Module pattern

variable "name" {
  type        = string
  description = "The name of the resource group. Changing this forces a new resource to be created."
  nullable    = false
}

variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new resource to be created."
  nullable    = false
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags which should be assigned to the Resource Group."
  default     = {}
  nullable    = false
}

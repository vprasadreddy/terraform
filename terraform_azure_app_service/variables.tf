# VARIABLES

###autentication###
variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}


###Common###
variable "tags" {
  type = map(string)
  default = {
    Terraform = "True"
    Author    = "Vara Prasad Reddy"
  }
  description = "A map of key value pairs that is used to tag resources created."
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure region to deploy resources to."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the services will be hosted."
  nullable    = false
}

variable "sku_name" {
  type        = string
  description = "sku type"
  default     = "B1"
}


variable "app_service_plan_name" {
  type        = string
  description = "App service plan name"
}


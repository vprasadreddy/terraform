variable "location" {
  type        = string
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
}

variable "tags" {
  type        = map(string)
  description = "A map of key value pairs that is used to tag resources created."
}


variable "service_plan_id" {
  type        = string
  description = "App service plan id"
  nullable    = false
}


variable "web_app_name" {
  type        = string
  description = "Webapp name"
  nullable    = false
}

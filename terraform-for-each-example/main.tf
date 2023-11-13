terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
}


provider "azurerm" {
  features {
  }
}

resource "null_resource" "resources-list" {
  for_each = toset(var.resources_list)
  triggers = {
    name = each.value
  }
}

output "resources_list_output" {
  value = null_resource.resources-list
}


resource "null_resource" "resources-map" {
  for_each = var.resources_map
  triggers = {
    name = each.value
  }
}

output "resources_map_output" {
  value = null_resource.resources-map
}

resource "null_resource" "resources_list_of_objects" {
  for_each = { for each in var.resources_list_of_objects : "${each.deployment_id}" => each }
  triggers = {
    name = each.key
  }
}

output "resources_list_of_objects_output" {
  value = null_resource.resources_list_of_objects
}

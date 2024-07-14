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
  for_each = { for resource in var.resources_list_of_objects : "${resource.deployment_name}" => resource }
  triggers = {
    name = each.key
  }
}

output "resources_list_of_objects_output" {
  value = null_resource.resources_list_of_objects
}

//conditionally create resources using for_each with list_of_objects

resource "null_resource" "conditional_resources_list_of_objects" {
  for_each = { for resource in var.resources_list_of_objects : "${resource.deployment_name}" => resource if resource.create_resource }
  triggers = {
    name = each.key
  }
}

output "conditional_resources_list_of_objects_output" {
  value = null_resource.conditional_resources_list_of_objects
}


//create multiple resources using for_each with map_of_objects
resource "null_resource" "resources_map_of_objects" {
  for_each = var.resources_map_of_objects
  triggers = {
    name = each.key
  }
}

output "resources_map_of_objects_output" {
  value = null_resource.resources_map_of_objects
}

//conditionally create resources using for_each with map_of_objects

resource "null_resource" "conditional_resources_map_of_objects" {
  for_each = { for resourceKey, resourcevalue in var.resources_map_of_objects : resourceKey => resourcevalue if resourcevalue.create_resource }
  triggers = {
    name = each.key
  }
}

output "conditional_resources_map_of_objects_output" {
  value = null_resource.conditional_resources_map_of_objects
}

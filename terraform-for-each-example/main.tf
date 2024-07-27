//create multiple resources using count
resource "azurerm_resource_group" "resource_group_using_count" {
  count    = length(var.resource_groups)
  name     = "${var.resource_groups[count.index]}-rg"
  location = "eastus"
}

output "resource_group_using_count_output" {
  value = azurerm_resource_group.resource_group_using_count
}

# Splat expression to get only id of the resource groups. 
# The splat expression works only with count, lists, sets, and tuples.
output "resource_group_using_count_output_ids" {
  value = azurerm_resource_group.resource_group_using_count.*.id
}

output "resource_group_using_count_output_names" {
  value = azurerm_resource_group.resource_group_using_count[*].name
}

//create multiple resources using List
resource "null_resource" "resources_list" {
  for_each = toset(var.resources_list)
  triggers = {
    name = each.value
  }
}

output "resources_list_output" {
  value = null_resource.resources_list
}

//create multiple resources using list_of_objects

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

//create multiple resources using map
resource "null_resource" "resources_map" {
  for_each = var.resources_map
  triggers = {
    name = each.value
  }
}

output "resources_map_output" {
  value = null_resource.resources_map
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

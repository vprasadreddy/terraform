locals {
  list_of_objects_without_flatteen = [
    for k, v in var.networks : [for i, j in v.subnets : [
      {
        network_key = k,
        subnet_key  = j.name
      }
    ] if j.name != "" && lookup(j, "name", null) != null]
  ]
  list_of_objects_with_flatten = flatten([
    for k, v in var.networks : [for i, j in v.subnets : [
      {
        network_key = k,
        subnet_key  = j.name
      }
    ] if j.name != "" && lookup(j, "name", null) != null]
  ])
  list_of_objects_with_condition = flatten([
    for k, v in var.networks : [for i, j in v.subnets : [
      {
        network_key = k,
        subnet_key  = j.name
      }
    ] if j.name != "" && lookup(j, "name", null) != null]
  ])
  list_of_objects_with_merge = flatten([
    for k, v in var.networks : [for i, j in v.subnets : [
      merge({
        network_key = k,
        subnet_key  = j.name
      }, j)
  ] if j.name != "" && lookup(j, "name", null) != null]])
  list_of_objects_to_map_of_objects = flatten([
    for k, v in var.networks : { for i, j in v.subnets : "${k}-${j.name}" => j if j.name != "" && lookup(j, "name", null) != null }
  ])
  map_of_objects = { for index, subnet in flatten([
    for k, v in var.networks : [for i, j in v.subnets : [
      merge({
        network_key = k,
        subnet_key  = j.name
      }, j)
  ]]]) : "${subnet.network_key}-${subnet.subnet_key}" => subnet if subnet.subnet_key != "" && lookup(subnet, "subnet_key", null) != null }
  nested_map_of_objects_to_list_of_objects = flatten([
    for main_key, network in var.networks2 : [for sub_key, subnet in network.subnets : [{
      main_key          = main_key
      sub_key           = sub_key
      subnet_name       = subnet.name
      subnet_cidr_block = subnet.cidr_block
      }]
    ]
  ])
  nested_map_of_objects_to_map_of_objects = { for index, subnet in flatten([
    for main_key, network in var.networks2 : [for sub_key, subnet in network.subnets : [
      merge({
        network_key = main_key,
        subnet_key  = sub_key
      }, subnet)
  ]]]) : "${subnet.network_key}-${subnet.subnet_key}" => subnet if subnet.subnet_key != "" && lookup(subnet, "subnet_key", null) != null }
}

output "list_of_objects_without_flatteen" {
  value = local.list_of_objects_without_flatteen
}
output "list_of_objects_with_flatten" {
  value = local.list_of_objects_with_flatten
}

output "list_of_objects_with_condition" {
  value = local.list_of_objects_with_condition
}

output "list_of_objects_with_merge" {
  value = local.list_of_objects_with_merge
}

output "list_of_objects_to_map_of_objects" {
  value = local.list_of_objects_to_map_of_objects
}

output "map_of_objects" {
  value = local.map_of_objects
}

output "nested_map_of_objects_to_list_of_objects" {
  value = local.nested_map_of_objects_to_list_of_objects
}

output "nested_map_of_objects_to_map_of_objects" {
  value = local.nested_map_of_objects_to_map_of_objects
}

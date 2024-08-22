locals {
  list_of_objects = flatten([
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
  list_of_objects_map_of_objects = flatten([
    for k, v in var.networks : { for i, j in v.subnets : "${k}-${j.name}" => j if j.name != "" && lookup(j, "name", null) != null }
  ])
  map_of_objects = { for index, subnet in flatten([
    for k, v in var.networks : [for i, j in v.subnets : [
      merge({
        network_key = k,
        subnet_key  = j.name
      }, j)
  ]]]) : "${subnet.network_key}-${subnet.subnet_key}" => subnet if subnet.subnet_key != "" && lookup(subnet, "subnet_key", null) != null }
}

output "list_of_objects" {
  value = local.list_of_objects
}

output "list_of_objects_with_condition" {
  value = local.list_of_objects_with_condition
}

output "list_of_objects_with_merge" {
  value = local.list_of_objects_with_merge
}

output "list_of_objects_map_of_objects" {
  value = local.list_of_objects_map_of_objects
}

output "map_of_objects" {
  value = local.map_of_objects
}



locals {
  list_of_objects_without_flatteen = [
    for network_key, network in var.networks : [for subnet_index, subnet in network.subnets : [
      {
        network_key = network_key,
        subnet_key  = subnet.name
      }
    ]]
  ]

  list_of_objects_with_flatten = flatten([
    for network_key, network in var.networks : [for subnet_index, subnet in network.subnets : [
      {
        network_key = network_key,
        subnet_key  = subnet.name
      }
    ]]
  ])

  list_of_objects_with_flatten_and_condition = flatten([
    for network_key, network in var.networks : [for subnet_index, subnet in network.subnets : [
      {
        network_key = network_key,
        subnet_key  = subnet.name
      }
    ] if subnet.name != "" && lookup(subnet, "name", null) != null]
  ])

  list_of_objects_with_merge = flatten([
    for network_key, network in var.networks : [for subnet_index, subnet in network.subnets : [
      merge({
        network_key = network_key,
        subnet_key  = subnet.name
      }, subnet)
  ] if subnet.name != "" && lookup(subnet, "name", null) != null]])

  list_of_objects_to_map_of_objects = flatten([
    for network_key, network in var.networks : { for subnet_index, subnet in network.subnets : "${network_key}-${subnet.name}" => subnet if subnet.name != "" && lookup(subnet, "name", null) != null }
  ])

  map_of_objects = { for index, subnet in flatten([
    for network_key, network in var.networks : [for subnet_index, subnet_value in network.subnets : [
      merge({
        network_key = network_key,
        subnet_key  = subnet_value.name
      }, subnet_value)
  ]]]) : "${subnet.network_key}-${subnet.subnet_key}" => subnet if subnet.subnet_key != "" && lookup(subnet, "subnet_key", null) != null }

  nested_map_of_objects_to_list_of_objects = flatten([
    for network_key, network in var.networks2 : [for subnet_key, subnet in network.subnets : [{
      main_key          = network_key
      sub_key           = subnet_key
      subnet_name       = subnet.name
      subnet_cidr_block = subnet.cidr_block
      }]
    ]
  ])

  nested_map_of_objects_to_map_of_objects = { for index, subnet in flatten([
    for network_key, network in var.networks2 : [for subnet_key, subnet in network.subnets : [
      merge({
        network_key = network_key,
        subnet_key  = subnet_key
      }, subnet)
  ]]]) : "${subnet.network_key}-${subnet.subnet_key}" => subnet if subnet.subnet_key != "" && lookup(subnet, "subnet_key", null) != null }
}

output "list_of_objects_without_flatteen" {
  value = local.list_of_objects_without_flatteen
}
output "list_of_objects_with_flatten" {
  value = local.list_of_objects_with_flatten
}

output "list_of_objects_with_flatten_and_condition" {
  value = local.list_of_objects_with_flatten_and_condition
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

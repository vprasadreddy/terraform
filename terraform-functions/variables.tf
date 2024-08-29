variable "networks" {
  type = map(object({
    virtual_network_name = string
    cidr_block           = string
    subnets = list(object({
      name       = string
      cidr_block = string
    }))
  }))
}

variable "networks2" {
  type = map(object({
    virtual_network_name = string
    cidr_block           = string
    subnets = map(object({
      name       = string
      cidr_block = string
    }))
  }))
}
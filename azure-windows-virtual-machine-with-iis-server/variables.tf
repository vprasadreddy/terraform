variable "resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = ""
}

variable "resource_group_location" {
  type        = string
  description = "RG location in Azure"
  default     = ""
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
  default     = ""
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
  default     = ""
}

variable "vm_name" {
  type        = string
  description = "Virtual Machine name"
  default     = ""
}

variable "nic_name" {
  type        = string
  description = "Network interface card name"
  default     = ""
}

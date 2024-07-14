variable "resources_list" {
  type    = list(string)
  default = ["ubuntu-vm", "windows-vm", "macos-vm"]
}

variable "resources_map" {
  type = map(string)
  default = {
    "resource1" = "ubuntu-vm",
    "resource2" = "windows-vm",
    "resource3" = "macos-vm",
  }
}

variable "resources_list_of_objects" {
  type = list(object({
    deployment_name = string
    model_name      = string
    model_format    = string
    model_version   = string
    create_resource = bool
  }))
  default = [{
    deployment_name = "gpt35turbo16k"
    model_name      = "gpt-35-turbo-16k"
    model_version   = "0613"
    model_format    = "OpenAI"
    create_resource = true
    },
    {
      deployment_name = "gpt35turbo"
      model_name      = "gpt-35-turbo"
      model_version   = "0301"
      model_format    = "OpenAI"
      create_resource = false
    },
    {
      deployment_name = "gpt4"
      model_name      = "gpt-4"
      model_version   = "0314"
      model_format    = "OpenAI"
      create_resource = true
  }]
}

variable "resources_map_of_objects" {
  type = map(object({
    deployment_name = string
    model_name      = string
    model_format    = string
    model_version   = string
    create_resource = bool
  }))
  default = {
    "deployment_1" = {
      deployment_name = "gpt35turbo16k"
      model_name      = "gpt-35-turbo-16k"
      model_format    = "OpenAI"
      model_version   = "0613"
      create_resource = true
    },
    "deployment_2" = {
      deployment_name = "gpt4"
      model_name      = "gpt-4"
      model_format    = "OpenAI"
      model_version   = "0314"
      create_resource = false
  } }
}

variable "resources_list" {
  type    = list(string)
  default = ["resource1", "resource2", "resource3"]
}

variable "resources_map" {
  type = map(string)
  default = {
    "resource1" = "Tom",
    "resource2" = "Mike",
    "resource3" = "Jerry",
  }
}

variable "resources_list_of_objects" {
  type = list(object({
    deployment_id = string
    model_name    = string
    model_format  = string
  }))
  default = [{
    deployment_id = "gpt-3"
    model_name    = "gpt-3"
    model_format  = "OpenAI"
    },
    { deployment_id = "gpt-4"
      model_name    = "gpt-4"
      model_format  = "OpenAI"
  }]
}

variable "resources_list_of_objects2" {
  type = map(object({
    deployment_id = string
    model_name    = string
    model_format  = string
  }))
  default = {
    "deployment_1" = {
      deployment_id = "gpt-3"
      model_name    = "gpt-3"
      model_format  = "OpenAI"
    },
    "deployment_2" = { deployment_id = "gpt-4"
      model_name   = "gpt-4"
      model_format = "OpenAI"
  } }
}

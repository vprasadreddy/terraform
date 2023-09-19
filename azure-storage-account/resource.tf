terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-pipeline-rg"
    storage_account_name = "tfstatestorage9999"
    container_name       = "terraformstate"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "terraformrg" {
  name     = "terraform-resourcegroup"
  location = "eastus"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-1"
    storage_account_name = "terraformstorage9990"
    container_name       = "statefile"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "terraformrg" {
  name     = "resourcegroup-terraform"
  location = "eastus"
}

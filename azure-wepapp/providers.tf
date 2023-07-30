terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "resourcegroup-terraform"
    storage_account_name = "terraformstoragetest9999"
    container_name       = "statefile"
    key                  = "webapp.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

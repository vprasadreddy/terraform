terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

module "resourcegroup" {
  source              = "./modules/resourcegroup"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "storage_account" {
  source                   = "./modules/storageaccount"
  storage_account_name     = var.storage_account_name
  resource_group_name      = module.resourcegroup.resource_group_name_output
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

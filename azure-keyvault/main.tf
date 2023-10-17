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

resource "azurerm_key_vault" "yaml-pipeline-keyvault" {
  name                        = "yaml-pipeline-keyvault"
  location                    = "eastus"
  resource_group_name         = "keyvault-rg"
  enabled_for_disk_encryption = false
  tenant_id                   = "022ae18c-2132-4c67-9dae-cb6706a4ca4e"
  soft_delete_retention_days  = 90
  purge_protection_enabled    = false
  sku_name                    = "standard"
  tags = {
    soucre = "import"
  }
}

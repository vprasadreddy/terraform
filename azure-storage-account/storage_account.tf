resource "azurerm_storage_account" "terraformstoragetest9999" {
  name                     = "terraformstoragetest9999"
  resource_group_name      = azurerm_resource_group.terraformrg.name
  location                 = azurerm_resource_group.terraformrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "development",
    purpose     = "dev"
  }
}

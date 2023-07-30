resource "azurerm_service_plan" "terraform_windows_app_service_plan" {
  name                = "terraform_windows_app_service_plan"
  resource_group_name = azurerm_resource_group.terraformrg.name
  location            = azurerm_resource_group.terraformrg.location
  sku_name            = "F1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "terraform_windows_web_app" {
  name                = "terraform-windows-webapp"
  resource_group_name = azurerm_resource_group.terraformrg.name
  location            = azurerm_resource_group.terraformrg.location
  service_plan_id     = azurerm_service_plan.terraform_windows_app_service_plan.id

  site_config {
    always_on = false
  }
}

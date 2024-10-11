resource "azurerm_resource_group" "app_service_resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.app_service_resource_group.name
  location            = azurerm_resource_group.app_service_resource_group.location
  os_type             = "Linux"
  sku_name            = var.sku_name
  tags                = var.tags
}

module "linux_webapp" {
  source              = "./modules/azure_linux_web_app"
  resource_group_name = azurerm_resource_group.app_service_resource_group.name
  location            = azurerm_resource_group.app_service_resource_group.location
  sku_name            = var.sku_name
  tags                = var.tags
  service_plan_id     = azurerm_service_plan.app_service_plan.id
  web_app_name        = "web-app1-react-dev"
}

module "linux_webapp2" {
  source              = "./modules/azure_linux_web_app"
  location            = var.location
  resource_group_name = azurerm_resource_group.app_service_resource_group.name
  sku_name            = var.sku_name
  tags                = var.tags
  service_plan_id     = azurerm_service_plan.app_service_plan.id
  web_app_name        = "web-app2-react-dev"
}


resource "azurerm_resource_group" "default" {
  name     = "terraform-drift-demo"
  location = "eastus2"
}

resource "azurerm_service_plan" "default" {
  name                = "terraform-drift-demo-asp"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_storage_account" "storage" {
  name                     = "p2tfdrift"
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_linux_function_app" "app" {
  name                = "p2tfdriftfunc"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  service_plan_id            = azurerm_service_plan.default.id

  site_config {}
}
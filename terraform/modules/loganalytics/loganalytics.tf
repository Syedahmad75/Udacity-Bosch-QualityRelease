resource "azurerm_log_analytics_workspace" "qualityreleaseTfLA" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
}
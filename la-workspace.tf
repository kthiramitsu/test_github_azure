resource "azurerm_log_analytics_workspace""HUB-LA" {
name = var.HUB-LA
location = var.rg-location
resource_group_name = var.rg-HUB

retention_in_days = 730
}
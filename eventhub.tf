resource "azurerm_eventhub_namespace" "HUB-EH-NS" {
  name                = "${var.HUB-EH}-NS"
  location            = var.rg-location
  resource_group_name = var.rg-HUB
  sku                 = "Standard"
  


}


resource "azurerm_eventhub" "HUB-EH" {
  name                = var.HUB-EH
  namespace_name      = "${var.HUB-EH}-NS"
  resource_group_name = var.rg-HUB
  partition_count     = 2
  message_retention   = 1
}

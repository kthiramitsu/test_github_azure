/*ストレージアカウント*/

resource "azurerm_storage_account" "storagehub1056" {
name = var.storage
resource_group_name = var.rg-HUB
location = var.rg-location
account_tier = "Standard"
account_replication_type = "GRS"

allow_blob_public_access = false
is_hns_enabled = false
min_tls_version = "TLS1_0"
access_tier = "hot"


network_rules {
  default_action = "Deny"
  virtual_network_subnet_ids = ["${azurerm_subnet.vnet-C2-subnet.id}", "${azurerm_subnet.vnet-C3-subnet.id}",]
}

}


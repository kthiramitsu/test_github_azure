/*NSGフローログ設定*/

/*C2サブネットNSG*/
resource "azurerm_network_watcher_flow_log" "vnet-C2-nsg-flowlog" {
  network_watcher_name = "NetworkWatcher_japanwest"
  resource_group_name  = "NetworkWatcherRG"

  network_security_group_id = azurerm_network_security_group.vnet-C2-nsg.id
  storage_account_id        = azurerm_storage_account.storagehub1056.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 0
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.HUB-LA.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.HUB-LA.location
    workspace_resource_id = azurerm_log_analytics_workspace.HUB-LA.id
    interval_in_minutes   = 10
  }
}

/*C3サブネットNSG*/
resource "azurerm_network_watcher_flow_log" "vnet-C3-nsg-flowlog" {
  network_watcher_name = "NetworkWatcher_japanwest"
  resource_group_name  = "NetworkWatcherRG"

  network_security_group_id = azurerm_network_security_group.vnet-C3-nsg.id
  storage_account_id        = azurerm_storage_account.storagehub1056.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 0
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.HUB-LA.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.HUB-LA.location
    workspace_resource_id = azurerm_log_analytics_workspace.HUB-LA.id
    interval_in_minutes   = 10
  }
}

/*HUBサブネットNSG*/
resource "azurerm_network_watcher_flow_log" "vnet-HUB-nsg-flowlog" {
  network_watcher_name = "NetworkWatcher_japanwest"
  resource_group_name  = "NetworkWatcherRG"

  network_security_group_id = azurerm_network_security_group.vnet-HUB-nsg.id
  storage_account_id        = azurerm_storage_account.storagehub1056.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 0
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.HUB-LA.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.HUB-LA.location
    workspace_resource_id = azurerm_log_analytics_workspace.HUB-LA.id
    interval_in_minutes   = 10
  }
}

/*vm_linux_NSG*/
resource "azurerm_network_watcher_flow_log" "vm-linux-nsg-flowlog" {
  network_watcher_name = "NetworkWatcher_japanwest"
  resource_group_name  = "NetworkWatcherRG"

  network_security_group_id = azurerm_network_security_group.vm-linux-nsg.id
  storage_account_id        = azurerm_storage_account.storagehub1056.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 0
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.HUB-LA.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.HUB-LA.location
    workspace_resource_id = azurerm_log_analytics_workspace.HUB-LA.id
    interval_in_minutes   = 10
  }
}

/*vm_windows_NSG*/

resource "azurerm_network_watcher_flow_log" "vm-windows-nsg-flowlog" {
  network_watcher_name = "NetworkWatcher_japanwest"
  resource_group_name  = "NetworkWatcherRG"

  network_security_group_id = azurerm_network_security_group.vm-windows-nsg.id
  storage_account_id        = azurerm_storage_account.storagehub1056.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 0
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.HUB-LA.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.HUB-LA.location
    workspace_resource_id = azurerm_log_analytics_workspace.HUB-LA.id
    interval_in_minutes   = 10
  }
}
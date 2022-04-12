/*ファイアウォール*/

resource "azurerm_firewall" "FW-HUB" {
  name                = var.FW-HUB
  location            = var.rg-location
  resource_group_name = var.rg-HUB
  sku_tier = "Standard"
  
  firewall_policy_id = azurerm_firewall_policy.FW-HUB-policy.id

  

  ip_configuration {
    name                 = "${var.FW-HUB}-pip"
    subnet_id            = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.FW-HUB-pip.id

  }
 }

resource "azurerm_public_ip" "FW-HUB-pip" {
  name                = "${var.FW-HUB}-pip"
  location            = var.rg-location
  resource_group_name = var.rg-HUB
  allocation_method   = "Static"
  sku                 = "Standard"
}



/*ファイアウォールポリシー*/
resource "azurerm_firewall_policy" "FW-HUB-policy" {
  name                = "${var.FW-HUB}-policy"
  resource_group_name = var.rg-HUB
  location            = var.rg-location
  
  dns {
    proxy_enabled = true
  }

}

/*ファイアウォールポリシールール*/

resource "azurerm_firewall_policy_rule_collection_group" "FW-HUB-rcg"{ 
name               = "${var.FW-HUB}-rcg"
firewall_policy_id = azurerm_firewall_policy.FW-HUB-policy.id
priority = 500

/*アプリケーション規則コレクション*/
application_rule_collection {
    name = "WindowsUpdateCollection"
    priority = 200
    action = "Allow"
    rule {
        name = "Windows_Update"
        protocols {
          type = "Http"
          port = 80
        }
        protocols {
          type = "Https"
          port = 443
        }
        source_addresses = ["*"]
        destination_fqdn_tags = ["WindowsUpdate"]

    }
 }

 application_rule_collection {
    name = "YumCollection"
    priority = 210
    action = "Allow"
    rule {
        name = "Yum1"

        protocols {
          type = "Https"
          port = 443
        }

        source_addresses = ["*"]
        destination_fqdns = ["rhui-1.microsoft.com",]

    }

    rule {
        name = "Yum2"

        protocols {
          type = "Https"
          port = 443
        }

        source_addresses = ["*"]
        destination_fqdns = ["rhui-2.microsoft.com",]

    }

    rule {
        name = "Yum3"

        protocols {
          type = "Https"
          port = 443
        }

        source_addresses = ["*"]
        destination_fqdns = ["rhui-3.microsoft.com",]

    }
 }


/*ネットワーク規則コレクション*/
network_rule_collection {
    name = "HubRule"
    priority = 100
    action = "Allow"
    rule {
      name = "Rule1"
      protocols = ["TCP", "UDP"]
      source_addresses = ["111.108.6.158"]
      destination_addresses = ["10.189.0.64/26", "10.189.16.0/28"]
      destination_ports = ["22","3389"]
    }

    rule {
      name = "Rule2"
      protocols = ["TCP", "UDP"]
      source_addresses = ["10.189.0.64/26","10.189.16.0/28"]
      destination_addresses = ["111.108.6.158"]
      destination_ports = ["22","3389"]
    }
 }
}



/*DNAT規則コレクショングループ*/

resource "azurerm_firewall_policy_rule_collection_group" "FW-HUB-rcg-dnat" {
name               = "${var.FW-HUB}-rcg-dns"
firewall_policy_id = azurerm_firewall_policy.FW-HUB-policy.id
priority = 490

nat_rule_collection {
  name = "test-dnat"
  priority = 300
  action = "Dnat"
  rule {
    name = "test-dnat-01"
    protocols = ["TCP", "UDP"]
    source_addresses = ["111.108.6.158"]
    destination_address = "20.210.140.230"
    destination_ports = ["22"]
    translated_address = "10.189.0.68"
    translated_port = "22"
  }

  rule {
    name = "test-dnat-02"
    protocols = ["TCP", "UDP"]
    source_addresses = ["111.108.6.158"]
    destination_address = "20.210.140.230"
    destination_ports = ["3389"]
    translated_address = "10.189.16.4"
    translated_port = "3389"
  }
}
}
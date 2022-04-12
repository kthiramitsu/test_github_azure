/*C2Vnet*/

/*Vnet*/

resource "azurerm_virtual_network" "vnet-C2" {
    name = var.vnet-C2
    location = var.rg-location
    resource_group_name = var.rg-C2
    address_space       = ["10.189.16.0/26"]
    dns_servers = ["10.189.0.196"]

}

/*サブネット*/

resource "azurerm_subnet" "vnet-C2-subnet" {
    name                 = "${var.vnet-C2}-subnet"
    resource_group_name  = var.rg-C2
    virtual_network_name = var.vnet-C2
    address_prefixes     = ["10.189.16.0/28"]
    service_endpoints = ["Microsoft.Storage","Microsoft.Eventhub"]
}

/*NSG*/

resource "azurerm_network_security_group" "vnet-C2-nsg" {
  name                =  "${var.vnet-C2}-nsg"
  location = var.rg-location
  resource_group_name = var.rg-C2

security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

/*サブネットとNSGの関連付け*/

resource "azurerm_subnet_network_security_group_association" "vnet-C2-subnet-nsg-association" {
    subnet_id                 = azurerm_subnet.vnet-C2-subnet.id
    network_security_group_id = azurerm_network_security_group.vnet-C2-nsg.id
}


/*C3Vnet*/

/*Vnet*/

resource "azurerm_virtual_network" "vnet-C3" {
    name = var.vnet-C3
    location = var.rg-location
    resource_group_name = var.rg-C3
    address_space       = ["10.189.16.64/26"]
    dns_servers = ["10.189.0.196"]

}

/*サブネット*/

resource "azurerm_subnet" "vnet-C3-subnet" {
    name                 = "${var.vnet-C3}-subnet"
    resource_group_name  = var.rg-C3
    virtual_network_name = var.vnet-C3
    address_prefixes     = ["10.189.16.64/28"]
    service_endpoints = ["Microsoft.Storage","Microsoft.Eventhub"]
}

/*NSG*/

resource "azurerm_network_security_group" "vnet-C3-nsg" {
  name                =  "${var.vnet-C3}-nsg"
  location = var.rg-location
  resource_group_name = var.rg-C3

security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

/*サブネットとNSGの関連付け*/

resource "azurerm_subnet_network_security_group_association" "vnet-C3-subnet-nsg-association" {
    subnet_id                 = azurerm_subnet.vnet-C3-subnet.id
    network_security_group_id = azurerm_network_security_group.vnet-C3-nsg.id
}


/*HUBVnet*/

/*Vnet*/

resource "azurerm_virtual_network" "vnet-HUB" {
    name = var.vnet-HUB
    location = var.rg-location
    resource_group_name = var.rg-HUB
    address_space       = ["10.189.0.0/24"]
    dns_servers = ["10.189.0.196"]

}

/*サブネット*/

resource "azurerm_subnet" "vnet-HUB-subnet" {
    name                 = "${var.vnet-HUB}-subnet"
    resource_group_name  = var.rg-HUB
    virtual_network_name = var.vnet-HUB
    address_prefixes     = ["10.189.0.0/26"]
    service_endpoints = ["Microsoft.Storage","Microsoft.Eventhub"]
}

resource "azurerm_subnet" "vnet-HUB-subnet-dns" {
    name                 = "${var.vnet-HUB}-subnet-dns"
    resource_group_name  = var.rg-HUB
    virtual_network_name = var.vnet-HUB
    address_prefixes     = ["10.189.0.64/26"]
    service_endpoints = ["Microsoft.Storage","Microsoft.Eventhub"]
}

resource "azurerm_subnet" "GatewaySubnet" {
    name                 = "GatewaySubnet"
    resource_group_name  = var.rg-HUB
    virtual_network_name = var.vnet-HUB
    address_prefixes     = ["10.189.0.128/26"]
}

resource "azurerm_subnet" "AzureFirewallSubnet" {
    name                 = "AzureFirewallSubnet"
    resource_group_name  = var.rg-HUB
    virtual_network_name = var.vnet-HUB
    address_prefixes     = ["10.189.0.192/26"]
}

/*NSG*/

resource "azurerm_network_security_group" "vnet-HUB-nsg" {
  name                =  "${var.vnet-HUB}-nsg"
  location = var.rg-location
  resource_group_name = var.rg-HUB

security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

/*サブネットとNSGの関連付け*/

resource "azurerm_subnet_network_security_group_association" "vnet-HUB-subnet-nsg-association" {
    subnet_id                 = azurerm_subnet.vnet-HUB-subnet.id
    network_security_group_id = azurerm_network_security_group.vnet-HUB-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "vnet-HUB-subnet-dns-nsg-association" {
    subnet_id                 = azurerm_subnet.vnet-HUB-subnet-dns.id
    network_security_group_id = azurerm_network_security_group.vnet-HUB-nsg.id
}

/*C2toHUB　仮想ネットワークピアリング*/

/*C2側*/
resource "azurerm_virtual_network_peering" "peering-C2-to-HUB" {
    name                      = "peering-C2-to-HUB"
    resource_group_name       = var.rg-C2
    virtual_network_name      = var.vnet-C2
    remote_virtual_network_id = azurerm_virtual_network.vnet-HUB.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = false
    use_remote_gateways     = true
    depends_on = [azurerm_virtual_network.vnet-C2, azurerm_virtual_network.vnet-HUB , azurerm_virtual_network_gateway.vgw-HUB]
}

/*HUB側*/
resource "azurerm_virtual_network_peering" "peering-HUB-to-C2" {
    name                      = "peering-HUB-to-C2"
    resource_group_name       = var.rg-HUB
    virtual_network_name      = var.vnet-HUB
    remote_virtual_network_id = azurerm_virtual_network.vnet-C2.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = true
    use_remote_gateways     = false
    depends_on = [azurerm_virtual_network.vnet-C2, azurerm_virtual_network.vnet-HUB , azurerm_virtual_network_gateway.vgw-HUB]
}

/*C3toHUB 　仮想ネットワークピアリング*/

/*C3側*/
resource "azurerm_virtual_network_peering" "peering-C3-to-HUB" {
    name                      = "peering-C3-to-HUB"
    resource_group_name       = var.rg-C3
    virtual_network_name      = var.vnet-C3
    remote_virtual_network_id = azurerm_virtual_network.vnet-HUB.id
    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = false
    use_remote_gateways     = true
    depends_on = [azurerm_virtual_network.vnet-C3, azurerm_virtual_network.vnet-HUB , azurerm_virtual_network_gateway.vgw-HUB]
}

/*HUB側*/
resource "azurerm_virtual_network_peering" "peering-HUB-to-C3" {
    name                      = "peering-HUB-to-C3"
    resource_group_name       = var.rg-HUB
    virtual_network_name      = var.vnet-HUB
    remote_virtual_network_id = azurerm_virtual_network.vnet-C3.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = true
    use_remote_gateways     = false
    depends_on = [azurerm_virtual_network.vnet-C3, azurerm_virtual_network.vnet-HUB , azurerm_virtual_network_gateway.vgw-HUB]
}




/*仮想ネットワークゲートウェイ*/

resource "azurerm_virtual_network_gateway" "vgw-HUB" {
    name                = var.vgw-HUB
    location            = var.rg-location
    resource_group_name = var.rg-HUB

    type     = "ExpressRoute"
    vpn_type = "RouteBased"

    sku           = "Standard"

    ip_configuration {
    name                          = "${var.vgw-HUB}-pip"
    public_ip_address_id          = azurerm_public_ip.vgw-HUB-pip.id
    subnet_id                     = azurerm_subnet.GatewaySubnet.id
    }

    depends_on = [azurerm_public_ip.vgw-HUB-pip]

}

/*仮想ネットワークゲートウェイ用パブリックＩＰ
*/
resource "azurerm_public_ip" "vgw-HUB-pip" {
    name                = "${var.vgw-HUB}-pip"
    location            = var.rg-location
    resource_group_name = var.rg-HUB

    allocation_method = "Dynamic"
}
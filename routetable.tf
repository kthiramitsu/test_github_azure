/*C2サブネット向けルートテーブル*/
resource "azurerm_route_table" "rt-C2" {
  name = var.rt-C2
  location = var.rg-location
  resource_group_name = var.rg-C2

}

resource "azurerm_route" "rt-C2-Default" {
  name = "${var.rt-C2}-Default"
  resource_group_name = var.rg-C2
  route_table_name = var.rt-C2
  address_prefix = "0.0.0.0/0"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "rt-C2-HUB" {
  name = "${var.rt-C2}-HUB"
  resource_group_name = var.rg-C2
  route_table_name = var.rt-C2
  address_prefix = "10.189.0.0/26"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "rt-C2-dns" {
  name = "${var.rt-C2}-DNS"
  resource_group_name = var.rg-C2
  route_table_name = var.rt-C2
  address_prefix = "10.189.0.64/26"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_subnet_route_table_association" "C2" {
 subnet_id = azurerm_subnet.vnet-C2-subnet.id
 route_table_id = azurerm_route_table.rt-C2.id
 depends_on = [azurerm_subnet.vnet-C2-subnet]    
  
}

/*C3サブネット向けルートテーブル*/
resource "azurerm_route_table" "rt-C3" {
  name = var.rt-C3
  location = var.rg-location
  resource_group_name = var.rg-C3

}

resource "azurerm_route" "rt-C3-Default" {
  name = "${var.rt-C3}-Default"
  resource_group_name = var.rg-C3
  route_table_name = var.rt-C3
  address_prefix = "0.0.0.0/0"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "rt-C3-HUB" {
  name = "${var.rt-C3}-HUB"
  resource_group_name = var.rg-C3
  route_table_name = var.rt-C3
  address_prefix = "10.189.0.0/26"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "rt-C3-dns" {
  name = "${var.rt-C3}-DNS"
  resource_group_name = var.rg-C3
  route_table_name = var.rt-C3
  address_prefix = "10.189.0.64/26"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_subnet_route_table_association" "C3" {
 subnet_id = azurerm_subnet.vnet-C3-subnet.id
 route_table_id = azurerm_route_table.rt-C3.id
 depends_on = [azurerm_subnet.vnet-C3-subnet]    
  
}

/*HUBサブネット向けルートテーブル*/
resource "azurerm_route_table" "rt-HUB" {
  name = var.rt-HUB
  location = var.rg-location
  resource_group_name = var.rg-HUB

}

resource "azurerm_route" "rt-HUB-Default" {
  name = "${var.rt-HUB}-Default"
  resource_group_name = var.rg-HUB
  route_table_name = var.rt-HUB
  address_prefix = "0.0.0.0/0"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "rt-HUB-C2" {
  name = "${var.rt-HUB}-C2"
  resource_group_name = var.rg-HUB
  route_table_name = var.rt-HUB
  address_prefix = "10.189.16.0/28"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "rt-HUB-C3" {
  name = "${var.rt-HUB}-C3"
  resource_group_name = var.rg-HUB
  route_table_name = var.rt-HUB
  address_prefix = "10.189.16.64/28"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_subnet_route_table_association" "HUB" {
 subnet_id = azurerm_subnet.vnet-HUB-subnet.id
 route_table_id = azurerm_route_table.rt-HUB.id
 depends_on = [azurerm_subnet.vnet-HUB-subnet]    
  
}

resource "azurerm_subnet_route_table_association" "DNS" {
 subnet_id = azurerm_subnet.vnet-HUB-subnet-dns.id
 route_table_id = azurerm_route_table.rt-HUB.id
 depends_on = [azurerm_subnet.vnet-HUB-subnet-dns]    
  
}

/*GWサブネット向けルートテーブル*/
resource "azurerm_route_table" "rt-HUB-GW" {
  name = "${var.rt-HUB}-GW"
  location = var.rg-location
  resource_group_name = var.rg-HUB

}

resource "azurerm_route" "rt-HUB-GW-C2" {
  name = "${var.rt-HUB}-GW-C2"
  resource_group_name = var.rg-HUB
  route_table_name = "${var.rt-HUB}-GW"
  address_prefix = "10.189.16.0/28"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "rt-HUB-GW-C3" {
  name = "${var.rt-HUB}-GW-C3"
  resource_group_name = var.rg-HUB
  route_table_name = "${var.rt-HUB}-GW"
  address_prefix = "10.189.16.64/28"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "rt-HUB-GW-HUB" {
  name = "${var.rt-HUB}-GW-HUB"
  resource_group_name = var.rg-HUB
  route_table_name = "${var.rt-HUB}-GW"
  address_prefix = "10.189.0.0/26"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "rt-HUB-GW-DNS" {
  name = "${var.rt-HUB}-GW-DNS"
  resource_group_name = var.rg-HUB
  route_table_name = "${var.rt-HUB}-GW"
  address_prefix = "10.189.0.64/26"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_subnet_route_table_association" "GW" {
 subnet_id = azurerm_subnet.GatewaySubnet.id
 route_table_id = azurerm_route_table.rt-HUB-GW.id
 depends_on = [azurerm_subnet.GatewaySubnet]    
  
}

/*AZFWサブネット向けルートテーブル*/
resource "azurerm_route_table" "rt-HUB-FW" {
  name = "${var.rt-HUB}-FW"
  location = var.rg-location
  resource_group_name = var.rg-HUB

}

resource "azurerm_route" "rt-HUB-FW-Default" {
  name = "${var.rt-HUB}-FW-Default"
  resource_group_name = var.rg-HUB
  route_table_name = "${var.rt-HUB}-FW"
  address_prefix = "0.0.0.0/0"
  next_hop_type = "Internet"

}

resource "azurerm_subnet_route_table_association" "FW" {
 subnet_id = azurerm_subnet.AzureFirewallSubnet.id
 route_table_id = azurerm_route_table.rt-HUB-FW.id
 depends_on = [azurerm_subnet.AzureFirewallSubnet]    
  
}
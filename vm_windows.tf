/*Windows仮想マシン*/

/*WindowsVM用NIC*/
resource "azurerm_network_interface" "vm-windows-nic" {
  name                = "${var.vm-windows}-nic"
  location            = var.rg-location
  resource_group_name = var.rg-C2

  ip_configuration {
    name                          = "${var.vm-windows}-nic-ip"
    subnet_id                     = azurerm_subnet.vnet-C2-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

/*WindowsVM用NSG*/
resource "azurerm_network_security_group" "vm-windows-nsg" {
  name                =  "${var.vm-windows}-nsg"
  location = var.rg-location
  resource_group_name = var.rg-C2

security_rule {
    name                       = "RDP"
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

resource "azurerm_network_interface_security_group_association" "vm-windows-nic" {
    network_interface_id      = azurerm_network_interface.vm-windows-nic.id
    network_security_group_id = azurerm_network_security_group.vm-windows-nsg.id
}

/*Windows仮想マシン*/
resource "azurerm_windows_virtual_machine" "vm-windows" {
  name                = var.vm-windows
  resource_group_name = var.rg-C2
  location            = var.rg-location
  size                = "Standard_B1ms"
  admin_username      = "adminuser"
  admin_password      = "Ne0sk.2613!$"
  network_interface_ids = [azurerm_network_interface.vm-windows-nic.id]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2019-datacenter-gensecond"
    version = "latest"
  }

}
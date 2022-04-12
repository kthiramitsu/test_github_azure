/*Linux仮想マシン*/

/*LinuxVM用NIC*/
resource "azurerm_network_interface" "vm-linux-nic" {
  name                = "${var.vm-linux}-nic"
  location            = var.rg-location
  resource_group_name = var.rg-HUB
  dns_servers = ["8.8.8.8"]

  ip_configuration {
    name                          = "${var.vm-linux}-nic-ip"
    subnet_id                     = azurerm_subnet.vnet-HUB-subnet-dns.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.189.0.68"
  }
}

/*LinuxVM用NSG*/
resource "azurerm_network_security_group" "vm-linux-nsg" {
  name                =  "${var.vm-linux}-nsg"
  location = var.rg-location
  resource_group_name = var.rg-HUB

security_rule {
    name                       = "SSH"
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



resource "azurerm_network_interface_security_group_association" "vm-linux-nic" {
    network_interface_id      = azurerm_network_interface.vm-linux-nic.id
    network_security_group_id = azurerm_network_security_group.vm-linux-nsg.id
}

/*LinuxVM*/

resource "azurerm_linux_virtual_machine" "vm-linux" {
  name                = var.vm-linux
  resource_group_name = var.rg-HUB
  location            = var.rg-location
  size                = "Standard_B1ms"
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.vm-linux-nic.id,]

  admin_password = "Ne0sk.2613!$"
  disable_password_authentication = false

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8-LVM"
    version   = "latest"
  }
}


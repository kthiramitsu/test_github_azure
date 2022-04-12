/*リソースグループ*/

/*C2*/
resource "azurerm_resource_group" "rg-C2"{
    name = var.rg-C2
    location = var.rg-location
}

/*C3*/
resource "azurerm_resource_group" "rg-C3"{
    name = var.rg-C3
    location = var.rg-location
}

/*HUB*/
resource "azurerm_resource_group" "rg-HUB"{
    name = var.rg-HUB
    location = var.rg-location
}

/*test*/
resource "azurerm_resource_group" "rg-HUB"{
    name = "test"
    location = "Japanwest"
}
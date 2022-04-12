/*地域*/
variable "rg-location" {}

/*リソースグループ*/
variable "rg-C2" {}
variable "rg-C3" {}
variable "rg-HUB" {}

/*Vnet*/
variable "vnet-C2" {}
variable "vnet-C3" {}
variable "vnet-HUB" {}

/*ルートテーブル*/
variable "rt-C2" {}
variable "rt-C3" {}
variable "rt-HUB" {}


/*仮想ネットワークゲートウェイ*/
variable "vgw-HUB" {}

/*Azureファイアウォール*/
variable "FW-HUB" {}

/*ストレージアカウント*/
variable "storage" {}

/*Log Analyticsワークスペース*/
variable "HUB-LA" {}

/*Event Hub*/
variable "HUB-EH" {}

/*windows仮想マシン*/
variable "vm-windows" {}

/*linux仮想マシン*/
variable "vm-linux" {}
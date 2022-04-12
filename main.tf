terraform {
    required_providers {
      azurerm = {
       source = "hashicorp/azurerm"
       version = "=2.46.0"
      }
    }
}

provider "azurerm" {
    features {}
}

terraform {
    required_version = ">=0.12"
}
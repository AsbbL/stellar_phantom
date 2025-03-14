# Create a resource group
resource "azurerm_resource_group" "iWolly_RG" {
  name     = "iWolly"
  location = "West Europe"

tags = {
    owner = "wolfgang.aigner@redbull.com"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "iWolly-vnet" {
  name                = "iWolly-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.iWolly_RG.location
  resource_group_name = azurerm_resource_group.iWolly_RG.name
}

# Subnet 1
resource "azurerm_subnet" "iWolly-subnet-1" {
  name                 = "iWolly-subnet-1"
  resource_group_name  = azurerm_resource_group.iWolly_RG.name
  virtual_network_name = azurerm_virtual_network.iWolly-vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}
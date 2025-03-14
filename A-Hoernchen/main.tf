# Create a resource group
resource "azurerm_resource_group" "Hoernchen_RG" {
  name     = "Hoernchen-resources"
  location = "West Europe"

  tags = {
    owner = "franz.aigner@redbull.com"
  }
}


# Virtual Network
resource "azurerm_virtual_network" "A-Hoernchen-VN" {
  name                = "A-Hoernchen-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Hoernchen_RG.location
  resource_group_name = azurerm_resource_group.Hoernchen_RG.name
}

# Subnet 1
resource "azurerm_subnet" "A-Hoernchen-subnet-1" {
  name                 = "A-Hoernchen-subnet-1"
  resource_group_name  = azurerm_resource_group.Hoernchen_RG.name
  virtual_network_name = azurerm_virtual_network.A-Hoernchen-VN.name
  address_prefixes     = ["10.0.1.0/24"]
}
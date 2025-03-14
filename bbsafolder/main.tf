# Create a resource group
resource "azurerm_resource_group" "examplebbsa" {
  name     = "example-bbsanew"
  location = "West Europe"
  tags = {owner = "bibisha.bhandari@redbull.com"}
}

# Virtual Network
resource "azurerm_virtual_network" "bbsavnet" {
  name                = "bbsavnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.examplebbsa.location
  resource_group_name = azurerm_resource_group.examplebbsa.name
}

# Subnet 1
resource "azurerm_subnet" "bbsasubnet" {
  name                 = "bbsasubnet1"
  resource_group_name  = azurerm_resource_group.examplebbsa.name
  virtual_network_name = azurerm_virtual_network.bbsavnet.name
  address_prefixes     = ["10.0.0.0/24"]
}
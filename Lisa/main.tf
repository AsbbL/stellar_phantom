# Create a resource group
resource "azurerm_resource_group" "lisa-recources" {
  name     = "lisa-resources"
  location = "West Europe"

    tags = {
    owner = "Lisa.Jaeger@redbull.com"
    }
}
# Virtual Network
resource "azurerm_virtual_network" "lisa-vnet" {
  name                = "lisa-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.lisa-recources.location
  resource_group_name = azurerm_resource_group.lisa-recources.name
}

# Subnet 1
resource "azurerm_subnet" "lisa-subnet1" {
  name                 = "lisa-subnet-1"
  resource_group_name  = azurerm_resource_group.lisa-recources.name
  virtual_network_name = azurerm_virtual_network.lisa-vnet_terraform_network.name
  address_prefixes     = ["10.0.0.0/24"]
}
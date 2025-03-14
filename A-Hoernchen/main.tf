# Create a resource group
resource "azurerm_resource_group" "Hoernchen_RG" {
  name     = "Hoernchen-resources"
  location = "West Europe"

  tags = {
    owner = "franz.aigner@redbull.com"
  }
}

# Create a virtual network within the resource group
# resource "azurerm_virtual_network" "Hoernchen_Net" {
#  name                = "Hoernchen-network"
#  resource_group_name = azurerm_resource_group.Hoernchen_RG.name
#  location            = azurerm_resource_group.Hoernchen_RG.location
#  address_space       = ["10.1.0.0/16"]
#}


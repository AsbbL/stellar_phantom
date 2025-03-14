# Create a resource group
resource "azurerm_resource_group" "iWolly_RG" {
  name     = "iWolly"
  location = "West Europe"

tags = {
    owner = "wolfgang.aigner@redbull.com"
  }
}


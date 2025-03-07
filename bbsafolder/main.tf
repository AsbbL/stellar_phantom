# Create a resource group
resource "azurerm_resource_group" "examplebbsa" {
  name     = "example-bbsa"
  location = "West Europe"
}

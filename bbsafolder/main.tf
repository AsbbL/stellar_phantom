# Create a resource group
resource "azurerm_resource_group" "examplebbsa" {
  name     = "example-bbsanew"
  location = "West Europe"
}
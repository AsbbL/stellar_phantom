# Create a resource group
resource "azurerm_resource_group" "lisa-recources" {
  name     = "lisa-resources"
  location = "West Europe"

    tags = {
    owner = "Lisa.Jaeger@redbull.com"
    }
}
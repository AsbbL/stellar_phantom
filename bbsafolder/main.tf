# Create a resource group
resource "azurerm_resource_group" "examplebbsa" {
  name     = "example-bbsanew"
  location = "West Europe"
  tags = {owner = "bibisha.bhandari@redbull.com"}
}

# Virtual Network
resource "azurerm_virtual_network" "bbsavnet" {
  name                = "bbsavnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.examplebbsa.location
  resource_group_name = azurerm_resource_group.examplebbsa.name
}

# Subnet 1
resource "azurerm_subnet" "bbsasubnet" {
  name                 = "bbsasubnet"
  resource_group_name  = azurerm_resource_group.examplebbsa.name
  virtual_network_name = azurerm_virtual_network.bbsavnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Define the network interface

resource "azurerm_network_interface" "bmy-nic" {
  name                = "bmy-nic"
  location            = azurerm_resource_group.examplebbsa.location
  resource_group_name = azurerm_resource_group.examplebbsa.name

  ip_configuration {
    name                          = "bmy-ipcfg"
    subnet_id                     = azurerm_subnet.bbsasubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the virtual machine
resource "azurerm_linux_virtual_machine" "bbsavm" {
  name                = "bbsa-vm"
  location            = azurerm_resource_group.examplebbsa.location
  resource_group_name = azurerm_resource_group.examplebbsa.name
  network_interface_ids = [
    azurerm_network_interface.bmy-nic.id,
  ]

  size               = "Standard_B2s"
  admin_username     = "marchatonbbsa"
  admin_password     = "34FDA$#214f!"  # For demonstration purposes only. Use secure methods for production.
  disable_password_authentication = "false"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

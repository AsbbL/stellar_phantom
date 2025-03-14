# Create a resource group
resource "azurerm_resource_group" "lisa-recources" {
  name     = "lisa-resources"
  location = "Sweden Central"

    tags = {
    owner = "Lisa.Jaeger@redbull.com"
    }
}
# Virtual Network
resource "azurerm_virtual_network" "lisa-vnet" {
  name                = "lisa-vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.lisa-recources.location
  resource_group_name = azurerm_resource_group.lisa-recources.name
}

# Subnet 1
resource "azurerm_subnet" "lisa-subnet1" {
  name                 = "lisa-subnet2"
  resource_group_name  = azurerm_resource_group.lisa-recources.name
  virtual_network_name = azurerm_virtual_network.lisa-vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}


# Define the network interface

resource "azurerm_network_interface" "lisaVM-nic" {
  name                = "lisaVM-nic"
  location            = azurerm_resource_group.lisa-recources.location
  resource_group_name = azurerm_resource_group.lisa-recources.name

  ip_configuration {
    name                          = "lisaVM-ipcfg"
    subnet_id                     = azurerm_subnet.lisa-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "dtyryshkin-vm"
  location            = azurerm_resource_group.lisa-recources.location
  resource_group_name = azurerm_resource_group.lisa-recources.name
  network_interface_ids = [
    azurerm_network_interface.lisaVM-nic.id,
  ]
  size               = "Standard_B2s"
  admin_username     = "lisa"
  admin_password     = "Password123!"  # For demonstration purposes only. Use secure methods for production.
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
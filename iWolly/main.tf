# Create a resource group
resource "azurerm_resource_group" "iWolly_RG" {
  name     = "iWolly"
  location = "Germany West Central"

tags = {
    owner = "wolfgang.aigner@redbull.com"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "iWolly-vnet" {
  name                = "iWolly-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.iWolly_RG.location
  resource_group_name = azurerm_resource_group.iWolly_RG.name
}

# Subnet 1
resource "azurerm_subnet" "iWolly-subnet-1" {
  name                 = "iWolly-subnet-1"
  resource_group_name  = azurerm_resource_group.iWolly_RG.name
  virtual_network_name = azurerm_virtual_network.iWolly-vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}



# Define the network interface

resource "azurerm_network_interface" "iWolly-nic" {
  name                = "iWolly-nic"
  location            = azurerm_resource_group.iWolly_RG.location
  resource_group_name = azurerm_resource_group.iWolly_RG.name

  ip_configuration {
    name                          = "iWolly-ipcfg"
    subnet_id                     = azurerm_subnet.iWolly-subnet-1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "iWolly-vm"
  location            = azurerm_resource_group.iWolly_RG.location
  resource_group_name = azurerm_resource_group.iWolly_RG.name
  network_interface_ids = [
    azurerm_network_interface.iWolly-nic.id,
  ]
  size               = "Standard_B4ms"
  admin_username     = "iWOlly"
  admin_password     = "PA$$123"  # For demonstration purposes only. Use secure methods for production.
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
# Create a resource group
resource "azurerm_resource_group" "Hoernchen_RG" {
  name     = "Hoernchen-resources"
  location = "West Europe"

  tags = {
    owner = "franz.aigner@redbull.com"
  }
}


# Virtual Network
resource "azurerm_virtual_network" "A-Hoernchen-VN" {
  name                = "A-Hoernchen-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Hoernchen_RG.location
  resource_group_name = azurerm_resource_group.Hoernchen_RG.name
}

# Subnet 1
resource "azurerm_subnet" "A-Hoernchen-subnet-1" {
  name                 = "A-Hoernchen-subnet-1"
  resource_group_name  = azurerm_resource_group.Hoernchen_RG.name
  virtual_network_name = azurerm_virtual_network.A-Hoernchen-VN.name
  address_prefixes     = ["10.0.1.0/24"]
}


# Define the network interface

resource "azurerm_network_interface" "myVM-nic" {
  name                = "myVM-nic"
  location            = azurerm_resource_group.Hoernchen_RG.location
  resource_group_name = azurerm_resource_group.Hoernchen_RG.name

  ip_configuration {
    name                          = "A-Hoernchen-ipcfg"
    subnet_id                     = azurerm_subnet.A-Hoernchen-subnet-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.Hoernchen-pIP.id
  }
}

# define public IP
resource "azurerm_public_ip" "Hoernchen-pIP" {
  name                = "example-public-ip"
  location            = azurerm_resource_group.Hoernchen_RG.location
  resource_group_name = azurerm_resource_group.Hoernchen_RG.name
  allocation_method   = "Dynamic"
}


# Define the virtual machine
resource "azurerm_linux_virtual_machine" "Hoernchen-VM" {
  name                = "Hoernchen-VM"
  location            = azurerm_resource_group.Hoernchen_RG.location
  resource_group_name = azurerm_resource_group.Hoernchen_RG.name
  network_interface_ids = [
    azurerm_network_interface.myVM-nic.id,
  ]
  size               = "Standard_B1s"
  admin_username     = "A-Hoernchen"
  admin_password     = "!123abcDEF"  # For demonstration purposes only. Use secure methods for production.
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
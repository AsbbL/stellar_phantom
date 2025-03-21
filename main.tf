
### Beginning of A-Hoernchen Stuff

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

resource "azurerm_network_interface" "A-Hoernchen-VM-nic" {
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
    azurerm_network_interface.A-Hoernchen-VM-nic.id,
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

### End of A-Hoernchen Stuff

### Beginning of iWolly Stuff

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

### End of iWolly Stuff


### Beginning of bbsa Stuff

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

### End of bbsa Stuff
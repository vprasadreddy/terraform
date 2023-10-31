terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.72.0"
    }
  }

}

provider "azurerm" {
  features {}
}

# Reference Azure Key Vault
data "azurerm_key_vault" "terraform-keyvault2349" {
  name                = "terraform-keyvault2349"
  resource_group_name = "terraform-keyvault"
}
data "azurerm_key_vault_secret" "admin-password" {
  name         = "admin-password"
  key_vault_id = data.azurerm_key_vault.terraform-keyvault2349.id
}

data "azurerm_key_vault_secret" "admin-username" {
  name         = "admin-username"
  key_vault_id = data.azurerm_key_vault.terraform-keyvault2349.id
}

resource "azurerm_resource_group" "demo_rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "demo_vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name
}

resource "azurerm_subnet" "demo_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip_${var.vm_name}"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Development"
  }
}

resource "azurerm_network_interface" "demo_nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.demo_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.demo_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}



resource "azurerm_windows_virtual_machine" "demo_vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  size                = "Standard_B1s"
  admin_username      = data.azurerm_key_vault_secret.admin-username.value
  admin_password      = data.azurerm_key_vault_secret.admin-password.value
  network_interface_ids = [
    azurerm_network_interface.demo_nic.id,
  ]

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  //windows server

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }


  //windows 11
  /*   source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-pron"
    version   = "latest"
  } */
}

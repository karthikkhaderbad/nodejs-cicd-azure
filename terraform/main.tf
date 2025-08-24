provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
  subnet_name         = var.subnet_name
  subnet_prefixes     = ["10.0.1.0/24"]
}

module "vm" {
  source              = "./modules/vm"
  vm_name             = var.vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vm_size             = var.vm_size
  nic_name            = "${var.vm_name}-nic"
  subnet_id           = module.vnet.subnet_id
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
}

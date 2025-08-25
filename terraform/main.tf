provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_public_ip" "public_ip" {
  name                = "myVM-public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.vm_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  vnet_name       = var.vnet_name
  address_space   = var.address_space
  subnet_name     = var.subnet_name
  subnet_prefixes = var.subnet_prefixes
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  subnet_id                 = module.vnet.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  vm_name        = var.vm_name
  vm_size        = var.vm_size
  admin_username = var.admin_username
  ssh_public_key = file(var.ssh_public_key_path)

  subnet_id = module.vnet.subnet_id
}

resource "null_resource" "post_setup" {
  provisioner "file" {
    source      = "setup.sh"
    destination = "/tmp/setup.sh"

    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file("/home/karthik/.ssh/id_rsa")
      host        = module.vm.public_ip_address
      timeout     = "2m"            # Increase timeout for initial SSH
      #cbastion_host = var.bastion_ip # If behind jump host, else omit

    }
  }

  provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/setup.sh",
            "sudo /tmp/setup.sh"
    ]


    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file("/home/karthik/.ssh/id_rsa")
      host        = module.vm.public_ip_address
      timeout     = "2m"
    }
  }

  depends_on = [module.vm]
}

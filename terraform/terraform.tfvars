# Resource Group
resource_group_name = "myResourceGroup"
location            = "East US"

# Virtual Network
vnet_name       = "myVnet"
address_space   = ["10.0.0.0/16"]
subnet_name     = "mySubnet"
subnet_prefixes = ["10.0.1.0/24"]

# Virtual Machine
vm_name             = "myVM"
vm_size             = "Standard_B2s"
admin_username      = "azureuser"
ssh_public_key_path = "~/.ssh/id_rsa.pub"

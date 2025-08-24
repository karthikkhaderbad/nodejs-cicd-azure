variable "resource_group_name" {
  default = "myResourceGroup"
}

variable "location" {
  default = "East US"
}

variable "vnet_name" {
  default = "myVNet"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  default = "mySubnet"
}

variable "subnet_prefixes" {
  default = ["10.0.1.0/24"]
}

variable "vm_name" {
  default = "myVM"
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  default = "azureuser"
}

variable "ssh_public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

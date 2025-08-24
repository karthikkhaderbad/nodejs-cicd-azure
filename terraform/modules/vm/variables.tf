variable "vm_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "vm_size" {
  default = "Standard_B1s"
}
variable "nic_name" {}
variable "subnet_id" {}
variable "admin_username" {}
variable "ssh_public_key_path" {}

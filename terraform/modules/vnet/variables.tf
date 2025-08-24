variable "vnet_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "address_space" {
  type = list(string)
}
variable "subnet_name" {}
variable "subnet_prefixes" {
  type = list(string)
}

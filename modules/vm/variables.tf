variable "resource_group_name" {
  type= string
  default = ""
}
variable "location" {
    type = string
    default = ""

}

variable "prefix" {
    type = string
    default = ""

}
variable "subnet_id" {
    type = string
    default = ""
  
}

variable "azurerm_storage_container_name" {
    type = string
    default = ""

}
variable "azurerm_storage_account_name" {
    type = string
    default = ""

}
variable "azurerm_storage_account_sas" {
    type = string
    default = ""

}
variable "network_security_group_id" {
    type = string
    default = ""

}
variable "environment" {
    type = string
    default = ""

}

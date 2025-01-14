variable "resource_group_name" {
  type= string
  default = ""
}
variable "location" {
    type = string
    default = ""

}

variable "dns_server_address" {
    type = map(string)
    default = {
      "francecentral" = "80.67.169.40"
      "francesouth" = "212.234.30.110"
      "germanynorth" = "168.119.27.54"
      "germanywestcentral" = "168.119.61.220"
      "italynorth" = "80.67.169.40"
      "northeurope" = "86.47.80.38	"
      "polandcentral" = "149.156.29.24"
      "westeurope" = "88.221.162.33"
    }
  
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
variable "vm_size" {
  type    = string
  default = "Standard_A1_v2"
}



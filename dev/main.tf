terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.106.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_groups" {
  source              = "../modules/resource_groups"
  resource_group_name = var.resource_group_name
  location            = var.location
  environment         = var.environment
  prefix              = var.prefix




}
module "network" {
  depends_on          = [module.resource_groups]
  source              = "../modules/network"
  resource_group_name = module.resource_groups.azurerm_resource_group_name
  location            = var.location
  prefix              = var.prefix
  address_space       = var.address_space
  address_prefixes    = var.address_prefixes


}
module "storage_account" {
  depends_on          = [module.network]
  source              = "../modules/storage_account"
  resource_group_name = module.resource_groups.azurerm_resource_group_name
  location            = var.location
  prefix              = var.prefix
  environment         = var.environment


}
module "public_vm" {
  depends_on                     = [module.storage_account,module.network]
  source                         = "../modules/vm"
  resource_group_name            = module.resource_groups.azurerm_resource_group_name
  location                       = var.location
  prefix                         = var.prefix
  subnet_id                      = module.network.subnet_id
  network_security_group_id      = module.network.network_security_group_id
  azurerm_storage_container_name = module.storage_account.azurerm_storage_container_name
  azurerm_storage_account_name   = module.storage_account.azurerm_storage_account_name
  azurerm_storage_account_sas    = module.storage_account.azurerm_storage_account_sas
  environment                    = var.environment


}
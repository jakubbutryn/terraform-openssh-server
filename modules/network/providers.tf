terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            configuration_aliases = [ azurerm.v4_8_0 ]
        }
    }
}
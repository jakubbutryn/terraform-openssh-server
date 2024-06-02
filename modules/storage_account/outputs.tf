
output "azurerm_storage_container_name" {
    value = azurerm_storage_container.this.name
  
}

output "azurerm_storage_account_name" {
    value = azurerm_storage_account.this.name
  
}
output "azurerm_storage_account_sas" {
  value = data.azurerm_storage_account_sas.this.sas
}
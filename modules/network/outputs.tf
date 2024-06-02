output "subnet_id" {
  value = azurerm_subnet.this.id
}
output "nsg_id" {
    value = azurerm_network_security_group.this.id
  
}
output "network_security_group_id" {
  value = azurerm_network_security_group.this.id
}
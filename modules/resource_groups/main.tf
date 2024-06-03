resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${var.prefix}-${var.environment}-${var.resource_group_name}"
}

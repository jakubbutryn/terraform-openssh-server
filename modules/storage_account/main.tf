resource "azurerm_storage_account" "this" {
  name                     = join("",[var.prefix,var.environment,"sa"])
  resource_group_name      =  var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}
resource "time_sleep" "wait_30_seconds" {
  depends_on = [azurerm_storage_account.this]

  create_duration = "5s"
}
resource "azurerm_storage_container" "this" {
  name                  = "${var.prefix}${var.environment}container"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
  depends_on = [ time_sleep.wait_30_seconds ]
}
data "azurerm_storage_account_sas" "this" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  https_only        = true
  signed_version    = "2022-11-02"

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = true
    table = true
    file  = true
  }

  start  = timestamp()
  expiry = timeadd(timestamp(), "24h")



  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = true
    process = true
    tag     = true
    filter  = true
  }

}

# Create public IPs
resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = "${var.prefix}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}


# Create network interface
resource "azurerm_network_interface" "my_terraform_nic" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "nic_configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.my_terraform_nic.id
  network_security_group_id = var.network_security_group_id 
}


resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "main" {
  depends_on = [tls_private_key.rsa-4096
  ]
  name                            = "${var.prefix}-vm"
  admin_username                  = "adminuser"
  admin_password                  = random_password.password.result
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.my_terraform_nic.id]

  size                            = "Standard_A1_v2"
  disable_password_authentication = "false"

  os_disk {
    name                 = "disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = 30

  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.rsa-4096.public_key_openssh

  }

}

resource "null_resource" "remoteScript" {
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "adminuser"
      password = random_password.password.result
      host     = azurerm_linux_virtual_machine.main.public_ip_address
    }
    inline = [
      "wget -O openvpn.sh https://get.vpnsetup.net/ovpn",
      "sudo bash openvpn.sh --auto",
      "sudo bash -c 'cd /usr/local/bin; curl -L https://aka.ms/downloadazcopy-v10-linux | tar --strip-components=1 --exclude=*.txt -xzvf -; chmod +x azcopy'",
      "azcopy cp \"./client.ovpn\" \"https://${var.azurerm_storage_account_name}.blob.core.windows.net/${var.azurerm_storage_container_name}${nonsensitive(var.azurerm_storage_account_sas)}\"",
      "cat client.ovpn",
      "echo https://${var.azurerm_storage_account_name}.blob.core.windows.net/${var.azurerm_storage_container_name}${nonsensitive(var.azurerm_storage_account_sas)} "


    ]
  }
}



resource "null_resource" "localScript" {
  depends_on = [null_resource.remoteScript]
    triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command     = "azcopy copy 'https://${var.azurerm_storage_account_name}.blob.core.windows.net/${var.azurerm_storage_container_name}/client.ovpn${(nonsensitive(var.azurerm_storage_account_sas))}' '${path.module}' "
    interpreter = ["PowerShell", "-Command"]
  }

}


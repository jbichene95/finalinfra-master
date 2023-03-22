resource "azurerm_network_interface" "main" {
  #for_each = var.vm-nic-name
  name                = "${var.vm-nic-name}"
  location            = "${var.resource_group_location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${var.subnet-id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = var.staging ==true ? "${var.public-ip-id}": null
  }
}





resource "azurerm_linux_virtual_machine" "vm-image" {
  name                  = "${var.vm-name}"
  location            = "${var.resource_group_location}"
  resource_group_name = "${var.resource_group_name}"
 
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.main.id]
  
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${var.public-key-path}")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
  version   = "latest"  
  }
}
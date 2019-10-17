

resource "azurerm_network_interface" "app-nic" {
  name                      = "my-app-nic"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  network_security_group_id = var.network_security_group_id

  ip_configuration {
    name                          = "myipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.app-pip.id
  }
}
resource "azurerm_public_ip" "app-pip" {
  name                = "${var.prefix}-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.prefix}-demo"
}

resource "azurerm_virtual_machine" "app" {
  name                = "${var.prefix}-demoApp"
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.vm_size

  network_interface_ids         = [azurerm_network_interface.app-nic.id]
  delete_os_disk_on_termination = "true"

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "${var.prefix}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

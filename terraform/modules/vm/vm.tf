resource "azurerm_network_interface" "vm-nic" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  size                = var.size
  admin_username      = var.username
  network_interface_ids = ["${azurerm_network_interface.vm-nic.id}"]
  admin_ssh_key {
    username   = var.username
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOPvJwT1EyR+PWE5Oen8XIWEl169KkAN2GSOU9Qvl3RrrcUPJooyMYk4RwbsVm/K29O7u1lZl9I8WlvYEqC+ZVTI9FR5M2nk4xdeJl75P2IHkdFE26QLiRJtJjog2+LGtzO9I8UpqZXHqzjC55B9PF2K+e+6Rd7fCDewP07ovfWrY29y94efcM+4jpy3NYs1i/bIxZsq6QquAXxHwmNQwguSQacEdqDXo29JZ7cK7MYmWNjRCuruZRqJEth3ekD1lC27ZW15QvJ16NN3mL21lA9n5u8F6BHykOBI/faW0TmRmLHy3Y90MKm4Jfgghd0qOM7vv3lR9xG2hFu3WKYK4r"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

# bastionhost security group
resource "azurerm_network_security_group" "sg_bastionhost" {
  name                  = "sg_bastionhost"
  location              = "East US"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"

  security_rule {
    name                        = "allow_ssh"
    priority                    = 1000
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }

}

# set security group
resource "azurerm_network_security_group" "sg-vmtarget" {
    name = "sg-vmtarget"
    location = "East US"
    resource_group_name   = "${azurerm_resource_group.resource_group.name}"

    security_rule {
        name = "default-allow-ssh"
        priority = 1000
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name = "deny-all"
        priority = 4000 
        direction = "Inbound"
        access = "Deny"
        protocol = "*"
        source_port_range = "*"
        destination_port_range = "*"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

}

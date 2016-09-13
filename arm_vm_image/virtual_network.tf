# arm_vm_image virtual network

# Create a resource group
resource "azurerm_virtual_network" "vnet" {
  name                  = "${var.environment}-vnet"
  location              = "East US"
  address_space         = ["172.29.0.0/24"]
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
}

resource "azurerm_subnet" "subnet-vm" {
  name                  = "subnet-vm"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name  = "${azurerm_virtual_network.vnet.name}"
  address_prefix        = "172.29.0.0/24"
}

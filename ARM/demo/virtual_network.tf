# arm_demo virtual network

# Create a resource group
resource "azurerm_virtual_network" "vnet" {
  name                  = "${var.environment}-vnet"
  location              = "East US"
  address_space         = ["172.29.0.0/16"]
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
}

resource "azurerm_subnet" "subnet-0" {
  name                  = "subnet-0"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name  = "${azurerm_virtual_network.vnet.name}"
  address_prefix        = "172.29.0.0/24"
}

resource "azurerm_subnet" "subnet-1" {
  name                  = "subnet-1"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name  = "${azurerm_virtual_network.vnet.name}"
  address_prefix        = "172.29.1.0/24"
}

resource "azurerm_subnet" "subnet-2" {
  name                  = "subnet-2"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name  = "${azurerm_virtual_network.vnet.name}"
  address_prefix        = "172.29.2.0/24"
}

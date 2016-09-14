# Configures a Resource Group in Azure
provider "azurerm" {
}

# Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name      = "${var.environment}"
  location  = "East US"
}

# Configures a Resource Group in Azure
provider "azurerm" {
}

# Create a resource group
resource "azurerm_resource_group" "smoketest" {
  name = "${var.environment}"
  location = "East US"
  tags {
      terraform = "yes"
  }
}

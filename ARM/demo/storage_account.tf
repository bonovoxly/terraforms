# configure storage account
resource "azurerm_storage_account" "storageaccount" {
    name = "${var.environment}sa2016"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    location = "eastus"
    account_type = "Standard_LRS"

}

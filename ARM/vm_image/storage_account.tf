# configure storage account
resource "azurerm_storage_account" "vmimage-storageaccount" {
    name = "${var.environment}storageaccount"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    location = "eastus"
    account_type = "Standard_LRS"

}

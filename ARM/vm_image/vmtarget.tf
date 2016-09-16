# arm_demo

# Create a virtual machine
resource "azurerm_virtual_machine" "vmtarget" {
    name                  = "vmtarget"
    location              = "East US"
    resource_group_name   = "${azurerm_resource_group.resource_group.name}"
    network_interface_ids = ["${azurerm_network_interface.vmtarget-nic.id}"]
    vm_size               = "Standard_A0"

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name          = "vmtarget-disk"
        vhd_uri       = "${azurerm_storage_account.vmimage-storageaccount.primary_blob_endpoint}${azurerm_storage_container.vmtarget-sc.name}/disk.vhd"
        caching       = "ReadWrite"
        create_option = "FromImage"
    }

    os_profile {
        computer_name  = "vmtarget"
        admin_username = "ubuntu"
        # this doesn't matter;  password login is disabled
        admin_password = ""
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
          path     = "/home/ubuntu/.ssh/authorized_keys"
          key_data = "${file("~/.ssh/b_dev_demo.pub")}"
        }
    }

}

# configure network interface
resource "azurerm_network_interface" "vmtarget-nic" {
    name                = "vmtarget-nic"
    location            = "East US"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"

    ip_configuration {
        name                          = "vmtarget-${count.index}"
        subnet_id                     = "${azurerm_subnet.subnet-0.id}"
        private_ip_address            = "172.29.0.4"
        private_ip_address_allocation = "static"
        public_ip_address_id          = "${azurerm_public_ip.vmtarget-public-ip.id}"
    }
    network_security_group_id  = "${azurerm_network_security_group.sg-vmtarget.id}"
    #network_security_group_id = "${azurerm_network_security_group.${var.environ}.id}"
}


# configure storage container
resource "azurerm_storage_container" "vmtarget-sc" {
    name = "vmtarget-sc"
    resource_group_name   = "${azurerm_resource_group.resource_group.name}"
    storage_account_name  = "${azurerm_storage_account.vmimage-storageaccount.name}"
    container_access_type = "private"
}


# set public IP
resource "azurerm_public_ip" "vmtarget-public-ip" {
    name                          = "vmtarget-public-ip"
    location                      = "East US"
    resource_group_name           = "${azurerm_resource_group.resource_group.name}"
    public_ip_address_allocation  = "dynamic"

}

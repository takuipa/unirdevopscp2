
# Creamos una máquina virtual por cada una de las entradas vm ["master", "worker1", "nfs"] 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "myVM" {
    count               = length(var.vms) # Por cada una de las entradas vm ["master", "worker1", "nfs"]
    name                = "my-first-azure-vm-${var.vms[count.index]}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size[count.index] # Definimos el tamaño ["Standard_D2_v2", "Standard_D1_v2", "Standard_D1_v2"] 
    admin_username      = "adminUsername"
    network_interface_ids = [ azurerm_network_interface.myNic[count.index].id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}
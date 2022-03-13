
# Security group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "mySecGroup" {
    count               = length(var.vms) # Por cada una de las entradas vm ["master", "worker1", "nfs"]
    name                = "sshtraffic-${var.vms[count.index]}"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    # Regla necesaria para poder desplegar app mysql
    security_rule {
        name                       = "MYSQL"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "31234"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    # Regla necesaria para poder desplegar app mysql servicio balanceado
    security_rule {
        name                       = "HAPRXY"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3306"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

# Vinculamos el security group al interface de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation" {
    count                     = length(var.vms) # Por cada una de las entradas vm ["master", "worker1", "nfs"]
    network_interface_id      = azurerm_network_interface.myNic[count.index].id
    network_security_group_id = azurerm_network_security_group.mySecGroup[count.index].id

}
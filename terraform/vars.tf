# Maquinas virutales
variable "vms" {
  type = list(string)
  description = "Máquinas virtuales a crear"
  default = ["master", "worker1", "nfs"] 
}

# Tamaño maquinas virtuales
# Standard_D2_v2 7 GB, 2 CPU 
# Standard_D1_v2 3.5 GB, 1
variable "vm_size" {
  type = list(string)
  description = "Tamaño de la máquina virtual"
  default = ["Standard_D2_v2", "Standard_D1_v2", "Standard_D1_v2"] 
}
variable "vms" {
  type = list(string)
  description = "Máquinas virtuales a crear"
  default = ["master", "worker01", "nfs"] 
}

variable "vm_size" {
  type = list(string)
  description = "Tamaño de la máquina virtual"
  default = ["Standard_D2_v2", "Standard_D1_v2", "Standard_D1_v2"] 
}
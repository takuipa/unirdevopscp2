#variable "vm_size" {
#  type = string
#  description = "Tamaño de la máquina virtual"
#  default = "Standard_D1_v2" # 3.5 GB, 1 CPU 
#}

variable "vms" {
  type = list(string)
  description = "Máquinas virtuales a crear"
  default = ["master", "worker01", "worker02", "nfs"] 
}

variable "vm_size" {
  type = list(string)
  description = "Tamaño de la máquina virtual"
  default = ["Standard_B2ms", "Standard_B2s", "Standard_B2s", "Standard_B2s"] 
}
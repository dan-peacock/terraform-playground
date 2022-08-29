variable "vm_size" {
    description = "Value of the vm_size for the azure VM"
    type = string
    default = "Standard_DS1_v2"
}

variable "default_password" {
    description = "inital password for VM"
    type = string
    default = ""
}

variable "tags" {
  default     = ""
  description = "Additional resource tags"
  type        = string
}
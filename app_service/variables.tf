variable "vm-nic-name" {
  type        = string
  default     = "nic"
  description = "list of network interfaces and vm names"
}
variable "vm-name" {
  type        = string
  default     = "vm"
  description = "list of network interfaces and vm names"
}

variable "resource_group_name" {
   type        = string
  default     = "nic-resource-grp"
  description = "resource group name for nica"
}

variable "resource_group_location" {
   type        = string
  default     = "eastus"
  description = "resource group name for nica"
}


variable "subnet-id" {
   type        = string
  default     = ""
  description = "id of subnet vm resides"
}


variable "public-ip-id" {
   type        = string
  default     = ""
  description = "public ip id , if left blank vm will be created without pub ip"
}

variable "staging" {
   type        = bool
  default     = true
  description = "assigns public ip to vm if staging is true"
}

variable  "public-key-path" {
  type        = string
  default     = "./test.pub"
  description = "public key path"
}
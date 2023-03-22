variable "resource-grp-name" {
  type        = string
  default     = ""
  description = "resource group name"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "network location"
}

variable "address-space" {
  type        = string
  default     = "10.0.0.0/16"
  description = "network adress-space"
}

variable subnet-names {
  type        = list
  default     = ["subnet-1" ,"subnet-2" ]
  description = "description"
}


variable subnet-prefixes {
  type        = list
  default     = ["10.0.1.0/24","10.0.2.0/24"]
  description = "description"
}


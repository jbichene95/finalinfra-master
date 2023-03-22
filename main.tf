resource "random_uuid" "jim-test" {
}
locals {
  name     = "test"
  location = "eastus"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "jim-resource-grp" {
  name     = local.name
  location = local.location

}

module "network" {

  source            = "./Network-Module"
  resource-grp-name = local.name
  location          = local.location
  subnet-names      = ["db-subnet", "app-subnet"]
  subnet-prefixes   = ["10.0.1.0/24", "10.0.2.0/24"]


}


module "vms" {
  source                  = "./Vm_module"
  vm-nic-name             = "test-id"
  resource_group_name     = local.name
  resource_group_location = local.location
  subnet-id               = module.network.subnet-ids[0]
}



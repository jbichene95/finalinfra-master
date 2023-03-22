resource "azurerm_network_ddos_protection_plan" "ddos-cover" {
  name                = "${var.resource-grp-name}-anti_ddos"
  location            = "${var.location}"
  resource_group_name = "${var.resource-grp-name}"
}




resource "azurerm_virtual_network" "test_app-vn" {
  name                = "${var.resource-grp-name}-network"
  location            = "${var.location}"
  resource_group_name = "${var.resource-grp-name}"
  address_space       = ["${var.address-space}"]
  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.ddos-cover.id
    enable = true
  }
}

resource "azurerm_subnet" "db-subnet" {
  name                 = "${var.subnet-names[count.index]}"
  resource_group_name  = "${var.resource-grp-name}"
  virtual_network_name = "${azurerm_virtual_network.test_app-vn.name}"
  address_prefixes     = ["${var.subnet-prefixes[count.index]}"]
  count = "${length(var.subnet-names)}"


}


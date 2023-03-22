
resource "azurerm_subnet" "db-subnet" {
  name                 = "db_subnet"
  resource_group_name  = var.resource-grp-name
  virtual_network_name = var.virtual-virtual-network-name
  address_prefixes     = ["10.0.255.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "trybichene.mysql.database.azure.com"
  resource_group_name =  var.resource-grp-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "network-link" {
  name                  = "tryvnetzone.com"
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = var.virtual-virtual-network_id.id
  resource_group_name   = var.resource-grp-name
}

resource "azurerm_mysql_flexible_server" "try_server" {
  name                   = "trial-server"
  resource_group_name    = var.resource-grp-name
  location               = var.resource-grp-location
  administrator_login    = "psqladmin"
  administrator_password = "H@Sh1CoR3!"
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.db-subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.dns_zone.id
  sku_name               = "GP_Standard_D2ds_v4"

  depends_on = [azurerm_private_dns_zone_virtual_network_link.network-link]
}
resource "azurerm_mysql_flexible_database"  "example" {
  name                = "poll"
  resource_group_name = var.resource-grp-name
  server_name         = azurerm_mysql_flexible_server.try_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}



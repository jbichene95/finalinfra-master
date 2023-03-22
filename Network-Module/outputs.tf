output "subnet-ids" {
  value = azurerm_subnet.db-subnet[*].id
}
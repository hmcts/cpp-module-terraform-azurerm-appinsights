resource "azurerm_resource_group" "new" {
  count = var.resource_group.existing ? 0 : 1

  name     = var.resource_group.name
  location = var.location

  tags = var.tags
}

data "azurerm_resource_group" "existing" {
  count = var.resource_group.existing ? 1 : 0
  name  = var.resource_group.name
}

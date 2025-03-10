resource "azurerm_resource_group" "new" {
  count = var.resource_group_name != null && var.existing_resource_group_name == null ? 1 : 0

  name     = var.resource_group_name
  location = var.location

  tags = var.tags

  lifecycle {
    precondition {
      condition     = var.resource_group_name != null && var.existing_resource_group_name == null
      error_message = "You must provide either `resource_group_name` or `existing_resource_group_name` not both."
    }
  }
}

data "azurerm_resource_group" "existing" {
  count = var.existing_resource_group_name != null && var.resource_group_name == null ? 1 : 0
  name  = var.existing_resource_group_name

  lifecycle {
    precondition {
      condition     = var.existing_resource_group_name != null && var.resource_group_name == null
      error_message = "You must provide either `existing_resource_group_name` or `resource_group_name` not both."
    }
  }
}

locals {
  resource_group_name     = var.resource_group_name != null && var.existing_resource_group_name == null ? azurerm_resource_group.new[0].name : data.azurerm_resource_group.existing[0].name
  upper_environment       = upper(var.environment)
  mgmt_zone               = strcontains(local.upper_environment, "PRX") || strcontains(local.upper_environment, "PRP") || strcontains(local.upper_environment, "PRP") ? "MPD" : "MDV"
  environment_law_name    = "LA-${local.mgmt_zone}-${local.upper_environment}-INT-WS"
  environment_law_rg_name = "RG-${local.mgmt_zone}-${local.upper_environment}-INT-01"
  ampls_scope_name        = var.existing_private_link_scope_name == null && var.existing_private_link_scope_rg_name == null ? azurerm_monitor_private_link_scope.this[0].name : var.existing_private_link_scope_name
  ampls_scope_rg_name     = var.existing_private_link_scope_name == null && var.existing_private_link_scope_rg_name == null ? local.resource_group_name : var.existing_private_link_scope_rg_name
}

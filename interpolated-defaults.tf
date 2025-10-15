locals {
  upper_environment          = upper(var.environment)
  mgmt_zone                  = strcontains(local.upper_environment, "PRX") || strcontains(local.upper_environment, "PRP") || strcontains(local.upper_environment, "PRD") ? "MPD" : "MDV"
  environment_law_name       = "LA-${local.mgmt_zone}-${strcontains(local.upper_environment, "NFT02") ? "NFT" : local.upper_environment}-INT-WS"
  environment_law_rg_name    = "RG-${local.mgmt_zone}-${strcontains(local.upper_environment, "NFT02") ? "NFT" : local.upper_environment}-INT-01"
  internet_ingestion_enabled = var.private_connectivity == null ? true : var.internet_ingestion_enabled
  internet_query_enabled     = var.private_connectivity == null ? true : var.internet_query_enabled
  ampls_scope_rg_name        = var.private_connectivity == null ? null : var.private_connectivity.existing_scope ? var.private_connectivity.scope_rg_name : local.resource_group_name
  ampls_scope_name           = var.private_connectivity == null ? null : var.private_connectivity.existing_scope ? var.private_connectivity.scope_name : azurerm_monitor_private_link_scope.this[0].name
  resource_group_name        = var.resource_group.existing ? data.azurerm_resource_group.existing[0].name : azurerm_resource_group.new[0].name
}

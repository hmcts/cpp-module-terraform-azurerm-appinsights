resource "azurerm_log_analytics_workspace" "new" {
  count                      = var.log_analytics_workspace == null ? 1 : 0
  name                       = var.log_analytics_workspace.name
  location                   = var.location
  resource_group_name        = local.resource_group_name
  sku                        = var.log_analytics_workspace.sku
  retention_in_days          = var.log_analytics_workspace.retention_in_days
  daily_quota_gb             = var.log_analytics_workspace.daily_quota_gb
  internet_ingestion_enabled = local.internet_ingestion_enabled
  internet_query_enabled     = local.internet_query_enabled
}

data "azurerm_log_analytics_workspace" "existing" {
  count               = var.log_analytics_workspace == null ? 0 : 1
  name                = local.environment_law_name
  resource_group_name = local.environment_law_rg_name
}

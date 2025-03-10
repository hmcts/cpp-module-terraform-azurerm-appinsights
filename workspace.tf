resource "azurerm_log_analytics_workspace" "new" {
  count                      = var.log_analytics_workspace_name != null ? 1 : 0
  name                       = var.log_analytics_workspace_name
  location                   = var.location
  resource_group_name        = local.resource_group_name
  sku                        = var.log_analytics_workspace_sku
  retention_in_days          = var.log_analytics_workspace_retention
  daily_quota_gb             = var.log_analytics_workspace_quota
  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled
}

data "azurerm_log_analytics_workspace" "existing" {
  count               = var.log_analytics_workspace_name == null ? 1 : 0
  name                = local.environment_law_name
  resource_group_name = local.environment_law_rg_name
}

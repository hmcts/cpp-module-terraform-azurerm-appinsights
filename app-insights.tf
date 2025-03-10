resource "azurerm_application_insights" "this" {
  name                 = var.app_insights_name
  location             = var.location
  resource_group_name  = local.resource_group_name
  workspace_id         = var.log_analytics_workspace_name == null ? data.azurerm_log_analytics_workspace.existing[0].id : azurerm_log_analytics_workspace.new[0].id
  application_type     = var.app_insights_type
  daily_data_cap_in_gb = var.app_insights_daily_data_cap_in_gb
  retention_in_days    = var.app_insights_retention_in_days

  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled

  tags = var.tags
}

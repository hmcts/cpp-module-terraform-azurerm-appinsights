output "app_insights_id" {
  value = azurerm_application_insights.this.id
}

output "instrumentation_key" {
  value = azurerm_application_insights.this.instrumentation_key
}

output "connection_string" {
  value = azurerm_application_insights.this.connection_string
}

output "log_analytics_workspace_id" {
  value = var.log_analytics_workspace == null ? data.azurerm_log_analytics_workspace.existing[0].id : azurerm_log_analytics_workspace.new[0].id
}

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
  value = var.log_analytics_workspace == null ? azurerm_log_analytics_workspace.new[0].id : data.azurerm_log_analytics_workspace.existing[0].id
}

output "vault_app_insights_path" {
  description = "The path where the Application Insights secret was written."
  value       = vault_generic_secret.app_insights_conn_string.path
}

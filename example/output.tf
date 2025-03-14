output "app_insights_id" {
  value = module.app-insights.app_insights_id
}

output "instrumentation_key" {
  value     = module.app-insights.instrumentation_key
  sensitive = true
}

output "connection_string" {
  value     = module.app-insights.connection_string
  sensitive = true
}

output "log_analytics_workspace_id" {
  value = module.app-insights.log_analytics_workspace_id
}

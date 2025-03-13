resource "azurerm_monitor_private_link_scope" "this" {
  for_each            = var.existing_private_link_scope_name == null && var.existing_private_link_scope_rg_name == null && var.ampls_pe_subnet_id != null ? { 0 = "" } : {}
  name                = "${var.app_insights_name}-ampls"
  resource_group_name = local.resource_group_name

  # Open allows resources to connect to both private and public endpoints, setting these values to PrivateOnly will restrict access to only private endpoints
  ingestion_access_mode = var.private_link_scope_ingestion_mode
  query_access_mode     = var.private_link_scope_query_mode
}

resource "azurerm_private_endpoint" "this" {
  for_each            = var.existing_private_link_scope_name == null && var.existing_private_link_scope_rg_name == null && var.ampls_pe_subnet_id != null ? { 0 = "" } : {}
  name                = "${var.app_insights_name}-ampls-pe"
  location            = var.location
  resource_group_name = local.resource_group_name
  subnet_id           = var.ampls_pe_subnet_id
  private_service_connection {
    name                           = "${var.app_insights_name}-ampls-psc"
    private_connection_resource_id = azurerm_monitor_private_link_scope.this[0].id
    is_manual_connection           = false
    subresource_names              = ["azuremonitor"]
  }

  private_dns_zone_group {
    name                 = "${var.app_insights_name}-ampls-dns-zone-group"
    private_dns_zone_ids = var.private_link_scope_private_dns_zone_ids
  }

  depends_on = [
    azurerm_monitor_private_link_scope.this,
    azurerm_monitor_private_link_scoped_service.appinsights,
    azurerm_monitor_private_link_scoped_service.loganalytics
  ]
}

resource "azurerm_monitor_private_link_scoped_service" "appinsights" {
  for_each            = local.deploy_private_connectivity ? { 0 = "" } : {}
  name                = "${var.app_insights_name}-amplsservice"
  resource_group_name = local.ampls_scope_rg_name
  scope_name          = local.ampls_scope_name
  linked_resource_id  = azurerm_application_insights.this.id
}

resource "azurerm_monitor_private_link_scoped_service" "loganalytics" {
  for_each            = var.log_analytics_workspace_name != null && local.deploy_private_connectivity ? { 0 = "" } : {}
  name                = "${var.log_analytics_workspace_name}-amplsservice"
  resource_group_name = local.ampls_scope_rg_name
  scope_name          = local.ampls_scope_name
  linked_resource_id  = azurerm_log_analytics_workspace.new[0].id
}

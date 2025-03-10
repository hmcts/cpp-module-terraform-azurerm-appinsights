locals {
  dns_zones = {
    "privatelink-monitor-azure-com"             = "privatelink.monitor.azure.com"
    "privatelink-oms-opinsights-azure-com"      = "privatelink.oms.opinsights.azure.com"
    "privatelink-ods-opinsights-azure-com"      = "privatelink.ods.opinsights.azure.com"
    "privatelink-agentsvc-azure-automation-net" = "privatelink.agentsvc.azure-automation.net"
    "privatelink-blob-core-windows-net"         = "privatelink.blob.core.windows.net"
  }

  tags = {}
}

resource "azurerm_resource_group" "this" {
  name     = "example-resource-group"
  location = "UK South"
  tags     = local.tags
}

resource "azurerm_virtual_network" "this" {
  name                = "example-vnet"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "this" {
  name                 = "private-endpoints"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.0/16"]
}

resource "azurerm_private_dns_zone" "this" {
  for_each            = local.dns_zones
  resource_group_name = azurerm_resource_group.this.name
  name                = each.value
  tags                = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each              = local.dns_zones
  name                  = "${each.key}-vnet-link"
  virtual_network_id    = azurerm_virtual_network.this.id
  private_dns_zone_name = azurerm_private_dns_zone.this[each.key].name
  resource_group_name   = azurerm_resource_group.this.name
}

module "app-insights" {
  source = "./../"

  app_insights_name                       = "example-app-insights"
  log_analytics_workspace_name            = "example-log-analytics"
  location                                = "UK South"
  existing_resource_group_name            = azurerm_resource_group.this.name
  environment                             = "LAB"
  ampls_pe_subnet_id                      = azurerm_subnet.this.id
  private_link_scope_private_dns_zone_ids = [for dns_zone in azurerm_private_dns_zone.this : dns_zone.id]
  tags                                    = local.tags
}

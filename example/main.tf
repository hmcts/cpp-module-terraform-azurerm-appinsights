locals {
  dns_zones = var.private_connectivity ? {
    "privatelink-monitor-azure-com"             = "privatelink.monitor.azure.com"
    "privatelink-oms-opinsights-azure-com"      = "privatelink.oms.opinsights.azure.com"
    "privatelink-ods-opinsights-azure-com"      = "privatelink.ods.opinsights.azure.com"
    "privatelink-agentsvc-azure-automation-net" = "privatelink.agentsvc.azure-automation.net"
    "privatelink-blob-core-windows-net"         = "privatelink.blob.core.windows.net"
  } : {}

  resource_group_name = "example-app-insights-rg"
  location            = "UK South"

  tags = {}
}

resource "azurerm_resource_group" "this" {
  count    = var.private_connectivity ? 1 : 0
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "this" {
  count               = var.private_connectivity ? 1 : 0
  name                = "example-vnet"
  location            = azurerm_resource_group.this[0].location
  resource_group_name = azurerm_resource_group.this[0].name
  address_space       = ["10.0.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "this" {
  count                = var.private_connectivity ? 1 : 0
  name                 = "private-endpoints"
  resource_group_name  = azurerm_resource_group.this[0].name
  virtual_network_name = azurerm_virtual_network.this[0].name
  address_prefixes     = ["10.0.0.0/16"]
}

resource "azurerm_private_dns_zone" "this" {
  for_each            = local.dns_zones
  resource_group_name = azurerm_resource_group.this[0].name
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

  depends_on = [azurerm_subnet.this]

  app_insights_name = "example-app-insights"
  location          = local.location
  environment       = "LAB"
  tags              = local.tags

  log_analytics_workspace = {
    name = var.log_analytics_workspace_name
  }
  resource_group = {
    name     = local.resource_group_name
    existing = var.private_connectivity
  }

  private_connectivity = var.private_connectivity ? {
    subnet_id    = azurerm_subnet.this.id
    dns_zone_ids = [for dns_zone in azurerm_private_dns_zone.this : dns_zone.id]
  } : {}
}

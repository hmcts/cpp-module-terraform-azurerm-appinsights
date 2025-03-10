variable "location" {
  type        = string
  description = "Azure region into which resources are deployed."
  default     = "uksouth"
}

variable "environment" {
  type        = string
  description = "Environment into which resources are deployed."
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to apply to all resources."
  default     = {}
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
  default     = null
}

variable "existing_resource_group_name" {
  type        = string
  description = "Name of an existing resource group to deploy resources into."
  default     = null
}

variable "app_insights_name" {
  type        = string
  description = "Name of the app insights resource."
}

variable "app_insights_type" {
  type        = string
  description = "The type of app insights resource. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights#application_type-1 for valid values"
  default     = "other"
}

variable "app_insights_daily_data_cap_in_gb" {
  type        = number
  description = "The daily data cap in GB for the app insights resource."
  default     = 50
}

variable "app_insights_retention_in_days" {
  type        = number
  description = "The number of days the app insights resource should retain data for."
  default     = 30
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the log analytics workspace resource."
  default     = null
}

variable "log_analytics_workspace_sku" {
  type        = string
  description = "The SKU of log analytics workspace to deploy."
  default     = "PerGB2018"
}

variable "log_analytics_workspace_retention" {
  type        = number
  description = "The number of days the log analytics workspaces should retain data for."
  default     = 30
}

variable "log_analytics_workspace_quota" {
  type        = number
  description = "The daily quota for data ingestion in DB."
  default     = 50
}

variable "existing_private_link_scope_name" {
  type        = string
  description = "Name of an existing Azure Monitor Private Link Scope to use."
  default     = null
}

variable "existing_private_link_scope_rg_name" {
  type        = string
  description = "Name of the resource group the Azure Monitor Private Link Scope is deployed in."
  default     = null
}

variable "private_link_scope_ingestion_mode" {
  type        = string
  description = "value for ingestion_access_mode in azurerm_monitor_private_link_scope, can be either Open or PrivateOnly"
  default     = "Open"
}

variable "private_link_scope_query_mode" {
  type        = string
  description = "value for query_access_mode in azurerm_monitor_private_link_scope, can be either Open or PrivateOnly"
  default     = "Open"
}

variable "ampls_pe_subnet_id" {
  type        = string
  description = "The ID of the Subnet to which the private endpoint for AMPLS should be connected."
  default     = null
}

variable "private_link_scope_private_dns_zone_ids" {
  type        = list(string)
  description = "List of private DNS zone IDs to associate with the private link scope private endpoint."
  default     = []
}

variable "internet_ingestion_enabled" {
  type        = bool
  description = "Boolean flag to enable or disable internet ingestion for the app insights resource."
  default     = false
}

variable "internet_query_enabled" {
  type        = bool
  description = "Boolean flag to enable or disable internet query for the app insights resource."
  default     = false
}

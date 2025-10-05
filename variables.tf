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

variable "resource_group" {
  type = object({
    name     = string
    existing = optional(bool, false)
  })
  description = "Defines the resource group to deploy resources into. If `existing` is set to true, the module will use the existing resource group with the specified name."
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

variable "log_analytics_workspace" {
  type = object({
    name              = string
    sku               = optional(string, "PerGB2018")
    retention_in_days = optional(number, 30)
    daily_quota_gb    = optional(number, 50)
  })
  default = {
    name                = "LA-MDV-SIT-INT-WS"
    sku                 = "PerGB2018"
    retention_in_days   = 30
    daily_quota_gb      = 50
    resource_group_name = "rg-mdv-sit-int-01"
  }
}

variable "private_connectivity" {
  type = object({
    subnet_id      = string
    scope_name     = optional(string)
    scope_rg_name  = optional(string)
    existing_scope = optional(bool, false)
    ingestion_mode = optional(string, "Open")
    query_mode     = optional(string, "Open")
    dns_zone_ids   = optional(list(string), [])
  })
  default = null
}

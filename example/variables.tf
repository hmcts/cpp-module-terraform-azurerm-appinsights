variable "subscription_id" {
  type = string
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace."
  type        = string
  default     = null
}

variable "private_connectivity" {
  type        = bool
  default     = true
  description = "Should we setup private connectivity via an Azure Monitor Private Link Scope?"
}

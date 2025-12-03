# terraform-module-template


<!-- TODO fill in resource name in link to product documentation -->
Terraform module for [Resource name](https://example.com).

## Example

<!-- todo update module name
```hcl
module "todo_resource_name" {
  source = "git@github.com:hmcts/terraform-module-postgresql-flexible?ref=master"
  ...
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.22.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 5.5.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/application_insights) | resource |
| [azurerm_log_analytics_workspace.new](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_private_link_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/monitor_private_link_scope) | resource |
| [azurerm_monitor_private_link_scoped_service.appinsights](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/monitor_private_link_scoped_service) | resource |
| [azurerm_monitor_private_link_scoped_service.loganalytics](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/monitor_private_link_scoped_service) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.new](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/resource_group) | resource |
| [vault_generic_secret.app_insights_conn_string](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [azurerm_log_analytics_workspace.existing](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.existing](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_insights_daily_data_cap_in_gb"></a> [app\_insights\_daily\_data\_cap\_in\_gb](#input\_app\_insights\_daily\_data\_cap\_in\_gb) | The daily data cap in GB for the app insights resource. | `number` | `50` | no |
| <a name="input_app_insights_name"></a> [app\_insights\_name](#input\_app\_insights\_name) | Name of the app insights resource. | `string` | n/a | yes |
| <a name="input_app_insights_retention_in_days"></a> [app\_insights\_retention\_in\_days](#input\_app\_insights\_retention\_in\_days) | The number of days the app insights resource should retain data for. | `number` | `30` | no |
| <a name="input_app_insights_type"></a> [app\_insights\_type](#input\_app\_insights\_type) | The type of app insights resource. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights#application_type-1 for valid values | `string` | `"other"` | no |
| <a name="input_application"></a> [application](#input\_application) | Provide tag application | `string` | `"appinsights"` | no |
| <a name="input_builtFrom"></a> [builtFrom](#input\_builtFrom) | Provide tag builtFrom | `string` | `"cpp-module-terraform-azurerm-appinsights"` | no |
| <a name="input_businessArea"></a> [businessArea](#input\_businessArea) | Provide tag businessArea | `string` | `"Crime"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment into which resources are deployed. | `string` | n/a | yes |
| <a name="input_internet_ingestion_enabled"></a> [internet\_ingestion\_enabled](#input\_internet\_ingestion\_enabled) | Boolean flag to enable or disable internet ingestion for the app insights resource. | `bool` | `false` | no |
| <a name="input_internet_query_enabled"></a> [internet\_query\_enabled](#input\_internet\_query\_enabled) | Boolean flag to enable or disable internet query for the app insights resource. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region into which resources are deployed. | `string` | `"uksouth"` | no |
| <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace) | n/a | <pre>object({<br/>    name              = string<br/>    sku               = optional(string, "PerGB2018")<br/>    retention_in_days = optional(number, 30)<br/>    daily_quota_gb    = optional(number, 50)<br/>  })</pre> | `null` | no |
| <a name="input_private_connectivity"></a> [private\_connectivity](#input\_private\_connectivity) | n/a | <pre>object({<br/>    subnet_id      = string<br/>    scope_name     = optional(string)<br/>    scope_rg_name  = optional(string)<br/>    existing_scope = optional(bool, false)<br/>    ingestion_mode = optional(string, "Open")<br/>    query_mode     = optional(string, "Open")<br/>    dns_zone_ids   = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Defines the resource group to deploy resources into. If `existing` is set to true, the module will use the existing resource group with the specified name. | <pre>object({<br/>    name     = string<br/>    existing = optional(bool, false)<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to all resources. | `map(string)` | `{}` | no |
| <a name="input_test-var-notneeded"></a> [test-var-notneeded](#input\_test-var-notneeded) | test variable not needed | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_insights_id"></a> [app\_insights\_id](#output\_app\_insights\_id) | n/a |
| <a name="output_connection_string"></a> [connection\_string](#output\_connection\_string) | n/a |
| <a name="output_instrumentation_key"></a> [instrumentation\_key](#output\_instrumentation\_key) | n/a |
| <a name="output_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#output\_log\_analytics\_workspace\_id) | n/a |
| <a name="output_vault_app_insights_path"></a> [vault\_app\_insights\_path](#output\_vault\_app\_insights\_path) | The path where the Application Insights secret was written. |
<!-- END_TF_DOCS -->

## Contributing

We use pre-commit hooks for validating the terraform format and maintaining the documentation automatically.
Install it with:

```shell
$ brew install pre-commit terraform-docs
$ pre-commit install
```

If you add a new hook make sure to run it against all files:
```shell
$ pre-commit run --all-files
```

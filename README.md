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
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.21.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_log_analytics_workspace.new](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_private_link_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_private_link_scope) | resource |
| [azurerm_monitor_private_link_scoped_service.appinsights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_private_link_scoped_service) | resource |
| [azurerm_monitor_private_link_scoped_service.loganalytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_private_link_scoped_service) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.new](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_log_analytics_workspace.existing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.existing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ampls_pe_subnet_id"></a> [ampls\_pe\_subnet\_id](#input\_ampls\_pe\_subnet\_id) | The ID of the Subnet to which the private endpoint for AMPLS should be connected. | `string` | `null` | no |
| <a name="input_app_insights_daily_data_cap_in_gb"></a> [app\_insights\_daily\_data\_cap\_in\_gb](#input\_app\_insights\_daily\_data\_cap\_in\_gb) | The daily data cap in GB for the app insights resource. | `number` | `50` | no |
| <a name="input_app_insights_name"></a> [app\_insights\_name](#input\_app\_insights\_name) | Name of the app insights resource. | `string` | n/a | yes |
| <a name="input_app_insights_retention_in_days"></a> [app\_insights\_retention\_in\_days](#input\_app\_insights\_retention\_in\_days) | The number of days the app insights resource should retain data for. | `number` | `30` | no |
| <a name="input_app_insights_type"></a> [app\_insights\_type](#input\_app\_insights\_type) | The type of app insights resource. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights#application_type-1 for valid values | `string` | `"other"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment into which resources are deployed. | `string` | n/a | yes |
| <a name="input_existing_private_link_scope_name"></a> [existing\_private\_link\_scope\_name](#input\_existing\_private\_link\_scope\_name) | Name of an existing Azure Monitor Private Link Scope to use. | `string` | `null` | no |
| <a name="input_existing_private_link_scope_rg_name"></a> [existing\_private\_link\_scope\_rg\_name](#input\_existing\_private\_link\_scope\_rg\_name) | Name of the resource group the Azure Monitor Private Link Scope is deployed in. | `string` | `null` | no |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | Name of an existing resource group to deploy resources into. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region into which resources are deployed. | `string` | `"uksouth"` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | The name of the log analytics workspace resource. | `string` | `null` | no |
| <a name="input_log_analytics_workspace_quota"></a> [log\_analytics\_workspace\_quota](#input\_log\_analytics\_workspace\_quota) | The daily quota for data ingestion in DB. | `number` | `50` | no |
| <a name="input_log_analytics_workspace_retention"></a> [log\_analytics\_workspace\_retention](#input\_log\_analytics\_workspace\_retention) | The number of days the log analytics workspaces should retain data for. | `number` | `7` | no |
| <a name="input_log_analytics_workspace_sku"></a> [log\_analytics\_workspace\_sku](#input\_log\_analytics\_workspace\_sku) | The SKU of log analytics workspace to deploy. | `string` | `"PerGB2018"` | no |
| <a name="input_private_link_scope_ingestion_mode"></a> [private\_link\_scope\_ingestion\_mode](#input\_private\_link\_scope\_ingestion\_mode) | value for ingestion\_access\_mode in azurerm\_monitor\_private\_link\_scope, can be either Open or PrivateOnly | `string` | `"Open"` | no |
| <a name="input_private_link_scope_private_dns_zone_ids"></a> [private\_link\_scope\_private\_dns\_zone\_ids](#input\_private\_link\_scope\_private\_dns\_zone\_ids) | List of private DNS zone IDs to associate with the private link scope private endpoint. | `list(string)` | `[]` | no |
| <a name="input_private_link_scope_query_mode"></a> [private\_link\_scope\_query\_mode](#input\_private\_link\_scope\_query\_mode) | value for query\_access\_mode in azurerm\_monitor\_private\_link\_scope, can be either Open or PrivateOnly | `string` | `"Open"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to all resources. | `map(string)` | `{}` | no |
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

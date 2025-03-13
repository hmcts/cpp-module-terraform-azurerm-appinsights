package test

import (
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func getValidateOptions(t *testing.T) *terraform.Options {
	return terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../example",
		Upgrade:      true,
		NoColor:      true,
	})
}

func getDestroyPrivateEndpointOptions(t *testing.T, vars map[string]interface{}) *terraform.Options {
	return terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../example",
		Targets:      []string{"module.app-insights.azurerm_private_endpoint.this"},
		Vars:         vars,
	})
}

func getOutput(t *testing.T, terraformOptions *terraform.Options) (string, string, string, string) {
	instrumentationKey := terraform.Output(t, terraformOptions, "instrumentation_key")
	connectionString := terraform.Output(t, terraformOptions, "connection_string")
	id := terraform.Output(t, terraformOptions, "app_insights_id")
	workspaceId := terraform.Output(t, terraformOptions, "log_analytics_workspace_id")
	return instrumentationKey, connectionString, id, workspaceId
}

var testScenarios = map[string]struct {
	input map[string]interface{}
	lawId string
}{
	"CreateNewLogAnalyticsWorkspace": {
		input: map[string]interface{}{
			"subscription_id":              "8cdb5405-7535-4349-92e9-f52bddc7833a",
			"log_analytics_workspace_name": "example-log-analytics-workspace",
		},
		lawId: "/subscriptions/8cdb5405-7535-4349-92e9-f52bddc7833a/resourceGroups/example-app-insights-rg/providers/Microsoft.OperationalInsights/workspaces/example-log-analytics-workspace",
	},
	"UseExistingEnvironmentLogAnalyticsWorkspace": {
		input: map[string]interface{}{
			"subscription_id": "e6b5053b-4c38-4475-a835-a025aeb3d8c7",
		},
		lawId: "/subscriptions/e6b5053b-4c38-4475-a835-a025aeb3d8c7/resourceGroups/RG-MDV-LAB-INT-01/providers/Microsoft.OperationalInsights/workspaces/LA-MDV-LAB-INT-WS",
	},
	"NoPrivateConnectivityNewResourceGroup": {
		input: map[string]interface{}{
			"subscription_id":      "e6b5053b-4c38-4475-a835-a025aeb3d8c7",
			"private_connectivity": false,
		},
		lawId: "/subscriptions/e6b5053b-4c38-4475-a835-a025aeb3d8c7/resourceGroups/RG-MDV-LAB-INT-01/providers/Microsoft.OperationalInsights/workspaces/LA-MDV-LAB-INT-WS",
	},
}

func TestTerraformScenarios(t *testing.T) {
	for name, scenario := range testScenarios {
		t.Run(name, func(t *testing.T) {
			terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
				TerraformDir: "../../example",
				Upgrade:      true,
				Vars:         scenario.input,
				NoColor:      true,
				PlanFilePath: "./plan.out",
			})

			terraform.InitAndValidate(t, getValidateOptions(t))
			terraform.InitAndPlanAndShowWithStruct(t, terraformOptions)

			// Destroy the private endpoint first to avoid errors deleting subnet in use
			defer func() {
				terraform.Destroy(t, getDestroyPrivateEndpointOptions(t, scenario.input))
				// Wait for the NIC for the now deleted PE to be removed before destroying the rest of the resources
				time.Sleep(30 * time.Second)
				terraform.Destroy(t, terraformOptions)
			}()

			terraform.Apply(t, terraformOptions)

			instrumentationKey, connectionString, id, workspaceId := getOutput(t, terraformOptions)

			assert.NotEmpty(t, instrumentationKey)
			assert.NotEmpty(t, connectionString)
			assert.NotEmpty(t, id)
			assert.NotEmpty(t, workspaceId)
			assert.Equal(t, scenario.lawId, workspaceId)
		})
	}
}

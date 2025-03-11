package test

import (
	"testing"

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

func getOutput(t *testing.T, terraformOptions *terraform.Options) (string, string, string, string) {
	instrumentationKey := terraform.Output(t, terraformOptions, "instrumentation_key")
	connectionString := terraform.Output(t, terraformOptions, "connection_string")
	id := terraform.Output(t, terraformOptions, "app_insights_id")
	workspaceId := terraform.Output(t, terraformOptions, "log_analytics_workspace_id")
	return instrumentationKey, connectionString, id, workspaceId
}

func TestCreateNewLogAnalyticsWorkspace(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../example",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"subscription_id": "8cdb5405-7535-4349-92e9-f52bddc7833a",
			"log_analytics_workspace_name": "example-log-analytics-workspace",
		},
		NoColor:      true,
		PlanFilePath: "./plan.out",
	})

	terraform.InitAndValidate(t, getValidateOptions(t))
	terraform.InitAndPlanAndShowWithStruct(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	terraform.Apply(t, terraformOptions)

	instrumentationKey, connectionString, id, workspaceId := getOutput(t, terraformOptions)

	assert.NotEmpty(t, instrumentationKey)
	assert.NotEmpty(t, connectionString)
	assert.NotEmpty(t, id)
	assert.NotEmpty(t, workspaceId)
	assert.NotEqual(t, "/subscriptions/e6b5053b-4c38-4475-a835-a025aeb3d8c7/resourceGroups/RG-MDV-LAB-INT-01/providers/Microsoft.OperationalInsights/workspaces/LA-MDV-LAB-INT-WS", workspaceId)
}

func TestUseExistingEnvironmentLogAnalyticsWorkspace(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../example",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"subscription_id": "e6b5053b-4c38-4475-a835-a025aeb3d8c7",
		},
		NoColor:      true,
		PlanFilePath: "./plan.out",
	})

	terraform.InitAndValidate(t, getValidateOptions(t))
	terraform.InitAndPlanAndShowWithStruct(t, terraformOptions)

//	defer terraform.Destroy(t, terraformOptions)
//
//	terraform.Apply(t, terraformOptions)
//
//	instrumentationKey, connectionString, id, workspaceId := getOutput(t, terraformOptions)
//
//	assert.NotEmpty(t, instrumentationKey)
//	assert.NotEmpty(t, connectionString)
//	assert.NotEmpty(t, id)
//	assert.NotEmpty(t, workspaceId)
//	assert.NotEqual(t, "/subscriptions/e6b5053b-4c38-4475-a835-a025aeb3d8c7/resourceGroups/RG-MDV-LAB-INT-01/providers/Microsoft.OperationalInsights/workspaces/LA-MDV-LAB-INT-WS", workspaceId)
}

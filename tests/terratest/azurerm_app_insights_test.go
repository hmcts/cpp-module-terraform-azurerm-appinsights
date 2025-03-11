package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformValidatePlanApply(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../example",
		Upgrade: true,
		VarFiles: []string{"terratest.tfvars"},
		NoColor: true,
		PlanFilePath: "./plan.out",
	})

	validateOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../example",
		Upgrade: true,
		NoColor: true,
	})

	terraform.InitAndValidate(t, validateOptions)
	terraform.InitAndPlanAndShowWithStruct(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	terraform.Apply(t, terraformOptions)

	instrumentationKey := terraform.Output(t, terraformOptions, "instrumentation_key")
	connectionString := terraform.Output(t, terraformOptions, "connection_string")
	id := terraform.Output(t, terraformOptions, "app_insights_id")
	workspaceId := terraform.Output(t, terraformOptions, "log_analytics_workspace_id")

	assert.NotEmpty(t, instrumentationKey)
	assert.NotEmpty(t, connectionString)
	assert.NotEmpty(t, id)
	assert.Equal(t, "/subscriptions/e6b5053b-4c38-4475-a835-a025aeb3d8c7/resourceGroups/RG-MDV-LAB-INT-01/providers/Microsoft.OperationalInsights/workspaces/LA-MDV-LAB-INT-WS", workspaceId)
}

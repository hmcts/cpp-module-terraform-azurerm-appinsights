package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TerraformValidatePlanApply(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../example",
		Upgrade: true,
		VarFiles: []string{"../example/terratest.tfvars"},
		NoColor: true,
	})

	validateOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../example",
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
	assert.NotEmpty(t, workspaceId)
}
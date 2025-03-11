import {
  to       = azurerm_resource_group.this
  id       = "/subscriptions/e6b5053b-4c38-4475-a835-a025aeb3d8c7/resourceGroups/example-app-insights-rg"
  for_each = var.subscription_id == "e6b5053b-4c38-4475-a835-a025aeb3d8c7" ? { "do" = "something" } : {}
}

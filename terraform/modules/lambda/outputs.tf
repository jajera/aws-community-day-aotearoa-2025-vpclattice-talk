output "lambda_arns" {
  description = "Map of all security group IDs"
  value = {
    analytics_service   = module.lambda_analytics_service.arn
    inventory_service   = module.lambda_inventory_service.arn
    notfound_service    = module.lambda_notfound_service.arn
    orders_service      = module.lambda_orders_service.arn
    payments_service    = module.lambda_payments_service.arn
    products_service    = module.lambda_products_service.arn
    products_service_v2 = module.lambda_products_service_v2.arn
  }
}

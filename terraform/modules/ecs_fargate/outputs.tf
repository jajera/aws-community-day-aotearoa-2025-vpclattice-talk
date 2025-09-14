output "analytics_service_alb_arn" {
  description = "The ARN of the Application Load Balancer for the analytics service"
  value       = module.ecs_cluster_fargate.alb_arns["analytics-service"]
}

variable "name_prefix" {
  type        = string
  description = "The prefix name of the resources"
}

variable "vpc_ids" {
  type        = map(string)
  description = "The IDs of the VPCs"
}

variable "security_group_ids" {
  type        = map(string)
  description = "The IDs of the security groups"
}

variable "route53_zone_name" {
  type        = string
  description = "The name of the Route 53 zone"
}

variable "lambda_arns" {
  type        = map(string)
  description = "The ARNs of the Lambda functions"
}

variable "ec2_notifications_service_instance_id" {
  type        = string
  description = "The instance ID of the EC2 notifications service"
}

variable "analytics_service_alb_arn" {
  type        = string
  description = "The ARN of the Analytics Service ALB"
}

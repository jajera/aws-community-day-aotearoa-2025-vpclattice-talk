output "ec2_notifications_service_instance_id" {
  description = "The ID of the EC2 notifications service instance"
  value       = module.ec2_notifications_service.instance_id
}
